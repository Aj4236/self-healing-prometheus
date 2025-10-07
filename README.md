# Self-Healing Prometheus

A **self-healing monitoring setup** that automatically detects and resolves NGINX downtime using **Prometheus**, a **Flask webhook**, and **Ansible automation**.

## 🚀 Project Overview

This project demonstrates a **full DevOps automation workflow**:

1. **Prometheus & Blackbox Exporter** monitors services (NGINX in this case).  
2. When NGINX goes down, **Prometheus Alertmanager** sends an alert to the Flask **webhook**.  
3. The webhook triggers an **Ansible playbook** that automatically:
   - Checks if the NGINX container exists
   - Restarts it if it is down
   - Starts it if it’s missing  

The workflow ensures **zero downtime** for critical services and showcases **hands-on CI/CD and infrastructure automation skills**.


## 🛠️ Tools & Technologies

- **Monitoring & Alerts:** Prometheus, Alertmanager, Blackbox Exporter  
- **Automation:** Ansible, Docker  
- **Webhook:** Flask (Python)  
- **Containerization:** Docker  
- **Logging & Debugging:** Flask logs, Ansible stdout  

---

## 📂 Project Structure

self-healing-prometheus/
├── Dockerfile # Flask webhook container
├── webhook.py # Flask app to receive Prometheus alerts
├── playbooks/
│ └── heal_nginx.yml # Ansible playbook to restart NGINX
├── requirements.txt # Python dependencies
├── README.md # Project documentation
└── .gitignore # Ignore unnecessary files

## ⚡ How It Works

1. **Prometheus monitors** the NGINX service.
2. **Alert triggers** when NGINX is down.
3. Flask webhook receives the alert and **runs the Ansible playbook**.  
4. NGINX container is **restarted automatically**.
5. Prometheus detects recovery and resolves the alert.

**Result:** Fully automated self-healing NGINX service with minimal downtime.

---

## 💻 Getting Started

**Prerequisites:** Docker, Ansible, Python 3

1. Clone the repository:
```bash
git clone https://github.com/Aj4236/self-healing-prometheus.git
cd self-healing-prometheus
Build and run the webhook container:

docker build -t ansible-webhook .
docker run -d --name ansible-webhook -p 5000:5000 ansible-webhook
Configure Prometheus Alertmanager to send alerts to http://<webhook-host>:5000/alert.

Place your NGINX container under Docker monitoring; the webhook + playbook will handle auto-recovery.

✅ Features
Automatic NGINX recovery on downtime

Real-time alert handling via webhook

Ansible automation for infrastructure management

Dockerized for easy deployment

Production-ready logging and monitoring setup

📈 Learning Outcomes
Hands-on experience with Prometheus monitoring and Alertmanager

![image alt](https://github.com/Aj4236/self-healing prometheus/blob/c01920a28034305c93a8d17ee70742cf42f8b450/Screenshot%20(1).png)

Building self-healing infrastructure with Ansible automation

Webhook integration for real-time alert handling

Managing Docker containers programmatically

Understanding DevOps best practices for reliability and uptime

📌 Future Enhancements
Add multi-host support via dynamic Ansible inventory

Replace Flask dev server with production-grade WSGI server (Gunicorn)

Add Slack/Email notifications for alerts

Extend self-healing to other critical services

🔗 Live Demo / References
GitHub Repository: self-healing-prometheus

Inspired by modern DevOps best practices
