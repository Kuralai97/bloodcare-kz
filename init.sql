CREATE TABLE IF NOT EXISTS donors (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(200) NOT NULL,
    blood_type VARCHAR(10) NOT NULL,
    city VARCHAR(100),
    phone VARCHAR(20),
    donations_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS blood_requests (
    id SERIAL PRIMARY KEY,
    hospital VARCHAR(200) NOT NULL,
    blood_type VARCHAR(10) NOT NULL,
    amount_liters DECIMAL(5,2),
    urgency VARCHAR(50) DEFAULT 'Орташа',
    status VARCHAR(50) DEFAULT 'Күтуде',
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS blood_stock (
    id SERIAL PRIMARY KEY,
    blood_type VARCHAR(10) UNIQUE NOT NULL,
    amount_liters DECIMAL(6,2) DEFAULT 0
);

INSERT INTO donors (full_name, blood_type, city, phone, donations_count) VALUES
('Асқар Бейсенов', 'А(+)', 'Алматы', '+7 701 111 1111', 8),
('Айгүл Сейткали', 'О(-)', 'Астана', '+7 702 222 2222', 5),
('Мұрат Жақсыбеков', 'В(+)', 'Шымкент', '+7 703 333 3333', 3),
('Зарина Оспанова', 'АВ(+)', 'Алматы', '+7 704 444 4444', 12),
('Дәурен Нұрланов', 'А(-)', 'Астана', '+7 705 555 5555', 1),
('Камила Әбенова', 'О(+)', 'Қарағанды', '+7 706 666 6666', 7),
('Серік Қасымов', 'В(-)', 'Атырау', '+7 707 777 7777', 4),
('Назгүл Ибрагимова', 'АВ(-)', 'Алматы', '+7 708 888 8888', 2);

INSERT INTO blood_requests (hospital, blood_type, amount_liters, urgency, status) VALUES
('Алматы қалалық ауруханасы', 'О(-)', 3.0, 'Шұғыл', 'Күтуде'),
('Астана медицина орталығы', 'А(+)', 2.0, 'Шұғыл', 'Күтуде'),
('Шымкент облыстық ауруханасы', 'В(-)', 1.5, 'Орташа', 'Өңделуде'),
('Қарағанды облыстық ауруханасы', 'АВ(+)', 1.0, 'Жоспарлы', 'Орындалды');

INSERT INTO blood_stock (blood_type, amount_liters) VALUES
('А(+)', 42.0),
('А(-)', 18.0),
('В(+)', 35.0),
('В(-)', 8.0),
('О(+)', 55.0),
('О(-)', 3.0),
('АВ(+)', 22.0),
('АВ(-)', 11.0);
