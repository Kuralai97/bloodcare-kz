#!/bin/bash

echo "======================================"
echo "  BloodCare KZ — Автоматты орнату"
echo "======================================"

# Түстер
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 1. Жүйені жаңарту
echo -e "\n${YELLOW}1. Жүйе жаңартылуда...${NC}"
sudo apt-get update -q
echo -e "${GREEN}✅ Жүйе жаңартылды${NC}"

# 2. Docker тексеру
echo -e "\n${YELLOW}2. Docker тексерілуде...${NC}"
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✅ Docker орнатылған: $(docker --version)${NC}"
else
    echo -e "${RED}❌ Docker жоқ — орнатылуда...${NC}"
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# 3. Docker Compose тексеру
echo -e "\n${YELLOW}3. Docker Compose тексерілуде...${NC}"
if command -v docker compose &> /dev/null; then
    echo -e "${GREEN}✅ Docker Compose бар${NC}"
else
    echo -e "${RED}❌ Docker Compose жоқ — орнатылуда...${NC}"
    sudo apt-get install -y docker-compose-plugin
fi

# 4. Git тексеру
echo -e "\n${YELLOW}4. Git тексерілуде...${NC}"
if command -v git &> /dev/null; then
    echo -e "${GREEN}✅ Git орнатылған: $(git --version)${NC}"
else
    sudo apt-get install -y git
fi

# 5. UFW Firewall баптау
echo -e "\n${YELLOW}5. Firewall бапталуда...${NC}"
sudo ufw --force enable
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 5000/tcp
sudo ufw allow 3000/tcp
sudo ufw allow 9090/tcp
sudo ufw allow 8080/tcp
echo -e "${GREEN}✅ Firewall бапталды${NC}"

# 6. Fail2Ban орнату
echo -e "\n${YELLOW}6. Fail2Ban орнатылуда...${NC}"
sudo apt-get install -y fail2ban -q
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
echo -e "${GREEN}✅ Fail2Ban іске қосылды${NC}"

# 7. Жоба директориясына өту
echo -e "\n${YELLOW}7. Жоба директориясына өтілуде...${NC}"
cd ~/blooddonation
echo -e "${GREEN}✅ Директория: $(pwd)${NC}"

# 8. Docker Compose іске қосу
echo -e "\n${YELLOW}8. Docker контейнерлері іске қосылуда...${NC}"
docker compose up -d --build
echo -e "${GREEN}✅ Контейнерлер іске қосылды${NC}"

# 9. Күту — DB дайын болсын
echo -e "\n${YELLOW}9. Деректер қоры дайын болғанша күтілуде...${NC}"
sleep 10

# 10. Тексеру
echo -e "\n${YELLOW}10. Жүйе тексерілуде...${NC}"
if curl -s http://localhost:5000/health > /dev/null; then
    echo -e "${GREEN}✅ Flask қосымша жұмыс істеуде${NC}"
else
    echo -e "${RED}❌ Flask қосымша жауап бермеді${NC}"
fi

echo -e "\n======================================"
echo -e "${GREEN}  ✅ Орнату аяқталды!${NC}"
echo -e "======================================"
echo -e "🌐 Сайт:       http://localhost"
echo -e "🌐 Flask:      http://localhost:5000"
echo -e "📊 Grafana:    http://localhost:3000"
echo -e "📈 Prometheus: http://localhost:9090"
echo -e "🔧 Jenkins:    http://localhost:8080"
echo -e "======================================"
