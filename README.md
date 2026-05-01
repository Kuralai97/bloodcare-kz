# 🩸 BloodCare KZ — Қан тапсыру жүйесі

## Технологиялар стегі
- **ОС**: Ubuntu 24.04 (VirtualBox)
- **Backend**: Python Flask
- **Database**: PostgreSQL 15
- **Reverse Proxy**: Nginx
- **Контейнерлеу**: Docker + Docker Compose
- **IaC**: Terraform (Docker Provider) — 6 мысал
- **Мониторинг**: Prometheus + Grafana + Node Exporter
- **Қауіпсіздік**: UFW Firewall, Fail2Ban, Nginx Security Headers
- **CI/CD**: Jenkins
- **AI**: Groq API интеграциясы

## Іске қосу
```bash
chmod +x setup.sh
./setup.sh
```

## Қызметтер
| Қызмет | URL |
|--------|-----|
| Сайт | http://localhost |
| Flask | http://localhost:5000 |
| Grafana | http://localhost:3000 |
| Prometheus | http://localhost:9090 |
| Jenkins | http://localhost:8080 |
