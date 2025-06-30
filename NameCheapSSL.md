
## ✅ Step-by-Step Guide to Renew SSL Certificate (Namecheap + GoDaddy + EC2)

---

### 🔹 **Step 1: Renew the SSL Certificate on Namecheap**

1. Log in to your Namecheap account: [https://www.namecheap.com](https://www.namecheap.com)
2. Go to **Dashboard → SSL Certificates**
3. Click **Renew** next to the expiring certificate
4. Complete payment if required

> After renewing, you’ll be asked to **submit a CSR** (Certificate Signing Request)

---

### 🔹 **Step 2: Generate a CSR on your EC2 instance**

SSH into your EC2 instance:

```bash
ssh -i your-key.pem ubuntu@your-ec2-ip
```

Then run:

```bash
openssl req -new -newkey rsa:2048 -nodes -keyout yourdomain.key -out yourdomain.csr
```

* When prompted, fill in:

  * **Common Name**: your domain (e.g., `yourdomain.com`)
  * **Email**, **Organization**, etc.

This will generate:

* `yourdomain.csr` – submit this to Namecheap
* `yourdomain.key` – keep this safe; you'll need it to install the SSL later

---

### 🔹 **Step 3: Submit CSR to Namecheap**

1. Paste the contents of `yourdomain.csr` into the CSR field on Namecheap

   ```bash
   cat yourdomain.csr
   ```
2. Select **web-based** or **email-based domain validation**

---

### 🔹 **Step 4: Verify Domain Ownership via DNS (on GoDaddy)**

If you choose **DNS validation**:

1. Namecheap will show a **CNAME or TXT record**
2. Go to your **GoDaddy DNS settings**

   * Visit: [https://dcc.godaddy.com](https://dcc.godaddy.com)
   * Manage your domain → DNS → Add Record
3. Add the **record exactly as given**
4. Wait 10–30 minutes for propagation
5. Complete validation on Namecheap

---

### 🔹 **Step 5: Download the SSL Certificate from Namecheap**

Once issued, Namecheap will give you:

* **`yourdomain.crt`** (certificate)
* **CA Bundle** (may be `yourdomain.ca-bundle` or `bundle.crt`)

Download both to your local system or EC2 instance.

---

### 🔹 **Step 6: Install the SSL on EC2 (NGINX or Apache)**

#### 👉 For NGINX:

1. Copy the certificate files to EC2:

   ```bash
   scp -i your-key.pem yourdomain.crt ubuntu@your-ec2-ip:/home/ubuntu/
   scp -i your-key.pem bundle.crt ubuntu@your-ec2-ip:/home/ubuntu/
   ```

2. Combine certificates:

   ```bash
   cat yourdomain.crt bundle.crt > fullchain.crt
   ```

3. Configure NGINX:
   Edit your SSL-enabled server block:

   ```nginx
   server {
       listen 443 ssl;
       server_name yourdomain.com;

       ssl_certificate     /home/ubuntu/fullchain.crt;
       ssl_certificate_key /home/ubuntu/yourdomain.key;

       ...
   }
   ```

4. Test and reload:

   ```bash
   sudo nginx -t
   sudo systemctl reload nginx
   ```

---

#### 👉 For Apache:

1. Copy files and set paths in your Apache config:

   ```apache
   SSLCertificateFile /path/to/yourdomain.crt
   SSLCertificateKeyFile /path/to/yourdomain.key
   SSLCertificateChainFile /path/to/bundle.crt
   ```

2. Restart Apache:

   ```bash
   sudo systemctl restart apache2
   ```

---

### 🔹 **Step 7: Verify SSL Installation**

Go to:

```
https://yourdomain.com
```

Or check using: [https://www.ssllabs.com/ssltest/](https://www.ssllabs.com/ssltest/)


* **Renew early**: You can renew \~30 days before expiry
* **Let’s Encrypt Alternative**: If you want free auto-renew SSL, consider switching to Let’s Encrypt using [Certbot](https://certbot.eff.org/)

---

Would you like an NGINX config template or Certbot guide for EC2 as well?
