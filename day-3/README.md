
# 🚀 Terraform + AWS + Flask App Deployment  

![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform)  
![AWS](https://img.shields.io/badge/AWS-Cloud-232F3E?logo=amazonaws)  
![Python](https://img.shields.io/badge/Python-3.10-3776AB?logo=python)  
![Flask](https://img.shields.io/badge/Flask-Web%20App-000000?logo=flask)  

This project demonstrates how to **deploy a Python Flask application** on an **AWS EC2 instance** using **Terraform**.  

---

## 📌 Features  
✅ Infrastructure as Code with **Terraform**  
✅ Flask app hosted on **EC2**  
✅ Security group allowing SSH & HTTP access  
✅ Project built & tested in **GitHub Codespaces**  
✅ Debugged common **Terraform & Git errors**  

---

## 📂 Project Structure  
```

My-Terraform/
│── day-3/
│   ├── main.tf              # Terraform configuration
│   ├── app.py               # Flask app
│   ├── terraform.tfstate    # Terraform state
│   ├── terraform.tfstate.backup
│   ├── .terraform.lock.hcl
│   └── .terraform/

````

---

## ⚙️ How to Deploy  

### 1️⃣ Clone Repository  
```bash
git clone https://github.com/<your-username>/My-Terraform.git
cd My-Terraform/day-3
````

### 2️⃣ Initialize Terraform

```bash
terraform init
```

### 3️⃣ Validate Configuration

```bash
terraform validate
```

### 4️⃣ Apply Configuration

```bash
terraform apply -auto-approve
```

### 5️⃣ Connect to EC2

```bash
ssh -i your-key.pem ubuntu@<EC2_PUBLIC_IP>
```

### 6️⃣ Install Flask

```bash
sudo apt update && sudo apt install -y python3-pip
pip3 install flask
```

### 7️⃣ Run Flask App

```bash
python3 app.py
```

Now open in your browser:
👉 `http://<EC2_PUBLIC_IP>:5000`

---

## 🐍 Flask App Example

```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, Terraform + Flask on AWS!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

---

## 🖥️ Architecture

```
                +-----------------------+
                |   GitHub Codespaces   |
                |  (Dev + Terraform)    |
                +----------+------------+
                           |
                  terraform apply
                           |
         +-----------------+------------------+
         |                                    |
 +-------+--------+                 +---------+---------+
 |   AWS VPC      |                 |  Security Group   |
 |  (Public Subnet)|                 | (SSH + HTTP open)|
 +-------+--------+                 +---------+---------+
         |                                    |
         v                                    v
   +-----+------------------------------------+-----+
   |                AWS EC2 Instance                |
   |  Ubuntu + Python + Flask (Hello World App)     |
   +------------------------------------------------+
```

---

## ⚡ Common Issues & Fixes

* **Error:** `fatal: Unable to create .git/index.lock`
  ✅ Fix:

  ```bash
  rm -f .git/index.lock
  ```

* **Error:** Flask not installed
  ✅ Fix:

  ```bash
  pip3 install flask
  ```

* **Error:** `src refspec main does not match any`
  ✅ Fix:

  ```bash
  git branch -M main
  git push origin main
  ```

---

## 📌 Key Learnings

* Provisioning AWS with **Terraform**
* Running Python Flask on **EC2**
* Debugging Terraform & Git errors
* Using **Codespaces** for DevOps practice

---

## 🔮 Next Steps

* Add **Load Balancer** + **Auto Scaling**
* Use **Terraform modules** for clean code
* Automate Flask deployment with **user\_data**

---

✨ Built while learning **DevOps & Cloud Engineering** 🚀

```

---

This one will look **eye-catching on GitHub** because of the badges at the top.  

👉 Do you want me to also make a **GitHub Pages portfolio version** (like a mini website) that shows this project in a visual way?
```
