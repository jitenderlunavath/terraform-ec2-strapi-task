# Terraform EC2 + Strapi Deployment

## Task Overview

This task demonstrates provisioning an AWS EC2 instance using **Terraform with a module structure**, generating a **.pem key managed by Terraform**, and deploying a **Strapi application** on the EC2 instance. The entire process is recorded in a Loom video and submitted via a GitHub Pull Request.

---

## Objectives

* Provision EC2 using Terraform
* Generate and manage SSH key (.pem) through Terraform
* Use Terraform **module structure**
* Deploy and run Strapi on EC2
* Record Loom video of the full process
* Push code to GitHub and raise a Pull Request

---

## Project Structure

```
terraform-ec2-strapi-task/
│
├── main.tf
├── provider.tf
├── outputs.tf
├── README.md
│
└── modules/
    └── ec2/
        ├── main.tf
        └── outputs.tf
```

---

## Technologies Used

* Terraform
* AWS EC2
* Node.js (v20)
* Strapi v5
* Git & GitHub

---

## Step 1: Provision EC2 with Terraform

### Initialize Terraform

```bash
terraform init
```

### Plan Infrastructure

```bash
terraform plan
```

### Apply Configuration

```bash
terraform apply
```

This will:

* Create an EC2 instance
* Generate a `.pem` key using Terraform
* Output the EC2 public IP

---

## Step 2: Connect to EC2

After Terraform apply, use the generated key:

```bash
ssh -i strapi-key.pem ubuntu@<EC2_PUBLIC_IP>
```

---

## Step 3: Install Node.js on EC2

```bash
sudo apt update -y
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs -y
node -v
```

---

## Step 4: Create and Run Strapi

```bash
npx create-strapi-app@latest strapi-app --no-run
cd strapi-app
```

### Create `.env` file

```bash
nano .env
```

Paste:

```
HOST=0.0.0.0
PORT=1337

APP_KEYS=key1,key2,key3,key4
API_TOKEN_SALT=token123
ADMIN_AUTH_SECRET=adminauthsecret123
JWT_SECRET=jwtsecret123
```

### Create admin config

```bash
mkdir -p config
nano config/admin.js
```

Paste:

```js
module.exports = ({ env }) => ({
  auth: {
    secret: env('ADMIN_AUTH_SECRET'),
  },
});
```

### Start Strapi

```bash
npm run develop
```

---

## Step 5: Access Strapi Admin Panel

Open in browser:

```
http://<EC2_PUBLIC_IP>:1337/admin
```

Create your first admin user.

---

Submission branch for internship task.

## GitHub Repository

Repository contains:

* Terraform configuration
* Module-based EC2 setup
* README documentation

---

## Pull Request

A Pull Request was created from the `submission` branch to `main` as part of the task requirement.

---

## Notes

* `.terraform/`, `.pem`, and `terraform.tfstate` files are excluded using `.gitignore`.
* Strapi runs in development mode for demonstration purposes.