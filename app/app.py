from flask import Flask, jsonify, render_template, request
import psycopg2
import os
import urllib.request
import urllib.error
import json

app = Flask(__name__)

GROQ_API_KEY = os.getenv("GROQ_API_KEY", "")

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "db"),
        database=os.getenv("DB_NAME", "blooddb"),
        user=os.getenv("DB_USER", "admin"),
        password=os.getenv("DB_PASS", "secret123")
    )

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/api/donors")
def get_donors():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id, full_name, blood_type, city, donations_count FROM donors")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{"id":r[0],"name":r[1],"blood_type":r[2],"city":r[3],"donations":r[4]} for r in rows])

@app.route("/api/requests")
def get_requests():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id, hospital, blood_type, amount_liters, urgency, status FROM blood_requests")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{"id":r[0],"hospital":r[1],"blood_type":r[2],"amount":r[3],"urgency":r[4],"status":r[5]} for r in rows])

@app.route("/api/stock")
def get_stock():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT blood_type, amount_liters FROM blood_stock")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{"blood_type":r[0],"amount":r[1]} for r in rows])

@app.route("/api/donors", methods=["POST"])
def add_donor():
    data = request.json
    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO donors (full_name, blood_type, city, phone, donations_count) VALUES (%s,%s,%s,%s,0) RETURNING id",
        (data["name"], data["blood_type"], data["city"], data.get("phone",""))
    )
    new_id = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"success": True, "id": new_id})

@app.route("/health")
def health():
    return jsonify({"status": "ok", "service": "blooddonation"})

@app.route("/api/ai", methods=["POST"])
def ai_answer():
    data = request.json
    question = data.get("question", "")

    if GROQ_API_KEY:
        try:
            payload = json.dumps({
                "model": "llama3-8b-8192",
                "messages": [
                    {"role": "system", "content": "Сен қан тапсыру жүйесінің ассистентісің. Қазақ тілінде қысқа жауап бер."},
                    {"role": "user", "content": question}
                ],
                "max_tokens": 300
            }).encode()

            req = urllib.request.Request(
                "https://api.groq.com/openai/v1/chat/completions",
                data=payload,
                headers={
                    "Authorization": f"Bearer {GROQ_API_KEY}",
                    "Content-Type": "application/json"
                }
            )
            with urllib.request.urlopen(req, timeout=10) as resp:
                result = json.loads(resp.read())
                answer = result["choices"][0]["message"]["content"]
                return jsonify({"answer": answer, "source": "Groq AI"})
        except Exception as e:
            print(f"Groq error: {e}")

    q = question.lower()
    answers = {
        "о(-)": "О(-) — универсалды донор. Барлық 8 қан тобына тапсыра алады!",
        "донор": "Донор болу шарттары: жас 18-65, салмақ 55кг+, соңғы 6 айда ауру болмауы керек.",
        "аб": "АВ(+) — универсалды реципиент. Кез келген қан тобынан қабылдай алады.",
        "пайда": "1 донация 3 адамның өмірін сақтайды! Жүрек ауруы қаупін 33% төмендетеді.",
        "кейін": "Қан тапсырғаннан кейін: 15 мин демалыңыз, 500мл су ішіңіз, 24 сағат спорт жасамаңыз."
    }
    for key, ans in answers.items():
        if key in q:
            return jsonify({"answer": ans, "source": "local"})

    return jsonify({"answer": "Сұрағыңызды нақтырақ жазыңыз.", "source": "local"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
