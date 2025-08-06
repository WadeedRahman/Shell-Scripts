Here's a **step-by-step guide to deploy a Next.js application on Heroku** and then point your **Squarespace domain** to it. The guide includes:

1. Manual Deployment to Heroku
2. Domain Configuration via Squarespace
3. Setting up CI/CD with GitLab

---

## ✅ Prerequisites

Before starting, make sure you have:

* A **Heroku** account: [https://heroku.com](https://heroku.com)
* **Heroku CLI** installed: [https://devcenter.heroku.com/articles/heroku-cli](https://devcenter.heroku.com/articles/heroku-cli)
* **GitLab** repository with your Next.js app
* A **Squarespace domain** (from Squarespace’s domain panel)

---

## 🔧 STEP 1: Manual Deployment of Next.js App to Heroku

---

### 1.1. Clone your GitLab project (if not already)

```bash
git clone https://gitlab.com/username/project-name.git
cd project-name
```

---

### 1.2. Create `Procfile` in root of the project (no extension)

```Procfile
web: npm run start
```

This tells Heroku how to start your app.

---

### 1.3. Update `package.json` scripts

Make sure these scripts exist:

```json
"scripts": {
  "dev": "next dev",
  "build": "next build",
  "start": "next start -p $PORT"
}
```

---

### 1.4. Install Dependencies (if not already)

```bash
npm install
```

---

### 1.5. Login to Heroku CLI

```bash
heroku login
```

---

### 1.6. Create Heroku App

```bash
heroku create your-app-name
```

If you want a specific name:

```bash
heroku create your-app-name --buildpack heroku/nodejs
```

---

### 1.7. Add a Git remote if not automatically added

```bash
heroku git:remote -a your-app-name
```

---

### 1.8. Commit Changes

```bash
git add .
git commit -m "Add Heroku deployment files"
```

---

### 1.9. Push to Heroku

```bash
git push heroku main
```

Heroku will build your app and deploy it.

---

### 1.10. Open your App

```bash
heroku open
```

---

## 🌐 STEP 2: Connect Squarespace Domain to Heroku

---

### 2.1. Go to Heroku Dashboard → Your App → Settings

Scroll to **Domains** and click **Add domain**

Add:

```
www.yourdomain.com
```

Heroku will give you a DNS target like:

```
your-app-name.herokuapp.com
```

---

### 2.2. Go to Squarespace Domain Settings

1. Log in to Squarespace
2. Go to: `Settings > Domains`
3. Select your domain
4. Scroll to **DNS Settings**
5. Edit or add a **CNAME** record:

```
Type: CNAME
Host: www
Value: your-app-name.herokuapp.com
TTL: 1 hour
```

Also add a **redirect (forwarding)** from the root domain to `www`.

---

### 2.3. Wait for DNS Propagation

It might take 5-15 minutes for the domain to work globally.

Test:

```
https://www.yourdomain.com
```

---

## 🔁 STEP 3: Set Up GitLab CI/CD for Heroku

---

### 3.1. Generate Heroku API Key

1. Go to: [https://dashboard.heroku.com/account](https://dashboard.heroku.com/account)
2. Scroll to **API Key** and copy it

---

### 3.2. In GitLab → Project → Settings → CI/CD → Variables

Add the following variables:

| Key               | Value                   |
| ----------------- | ----------------------- |
| `HEROKU_API_KEY`  | (Paste the API Key)     |
| `HEROKU_APP_NAME` | your-app-name           |
| `HEROKU_EMAIL`    | your Heroku login email |

---

### 3.3. Add `.gitlab-ci.yml` in root of project

```yaml
stages:
  - deploy

deploy_to_heroku:
  stage: deploy
  image: node:18
  only:
    - main
  script:
    - npm install -g heroku
    - heroku auth:token
    - heroku git:remote -a $HEROKU_APP_NAME
    - git remote -v
    - git config --global user.email "$HEROKU_EMAIL"
    - git config --global user.name "GitLab CI"
    - git push https://heroku:$HEROKU_API_KEY@git.heroku.com/$HEROKU_APP_NAME.git HEAD:main -f
```

This will automatically deploy every time you push to the `main` branch.

---

### ✅ CI/CD Test

1. Commit and push to `main`:

```bash
git add .
git commit -m "Test CI/CD"
git push origin main
```

2. GitLab pipeline will start → Heroku deploys the new version


