

## **1️⃣ How to Stop GitLab Brute-Force Login Attempts**

### **Immediate Actions:**

#### **a) Set `rack_attack` throttling in GitLab**

GitLab includes `rack_attack` middleware, which you can configure to block brute-force attempts.

**Example (in `/etc/gitlab/gitlab.rb`):**

```ruby
gitlab_rails['rack_attack_git_basic_auth'] = {
  enabled: true,
  maxretry: 5,
  findtime: 60,
  bantime: 3600
}
```

This will:

* Allow **5 attempts per minute**,
* Ban the IP for **1 hour** if exceeded.

---

#### **b) Fail2Ban Integration**

Use `fail2ban` to ban offending IPs at the server level.

##### **Steps:**

1. **Install Fail2Ban:**

```bash
sudo apt install fail2ban
```

2. **Configure Jail:**

Create a custom GitLab filter:

```bash
sudo nano /etc/fail2ban/filter.d/gitlab.conf
```

**Example filter:**

```
[Definition]
failregex = .*Failed login for user.*IP=<HOST>.*
ignoreregex =
```

3. **Create Jail:**

```bash
sudo nano /etc/fail2ban/jail.local
```

Add:

```ini
[gitlab]
enabled = true
port = http,https
filter = gitlab
logpath = /var/log/gitlab/gitlab-rails/production.log
maxretry = 5
findtime = 600
bantime = 3600
```

4. **Restart Fail2Ban:**

```bash
sudo systemctl restart fail2ban
```

---

#### **c) IP Whitelisting (Optional but Effective)**

If your GitLab is private or limited to a specific organization, restrict access via NGINX or firewall to specific IP ranges.

##### **Example for NGINX:**

```nginx
location / {
    allow YOUR_IP_RANGE;
    deny all;
}
```

---

## **2️⃣ Is Enabling 2FA Enough?**

**2FA is essential but not enough alone.**
Brute-force attacks still cause:

* Server load
* Account lockouts (denial of service)
* Potential password leakage (if weak passwords are used elsewhere)

So you still need **brute-force protections** like `rack_attack`, `fail2ban`, and firewall controls.

---

## **3️⃣ How to Update GitLab 16 to Latest Version Without Downtime**

### **Recommended Approach:**

#### **a) Zero-Downtime Update via Omnibus Package**

GitLab supports **rolling upgrades** if you follow **version jumps properly** (e.g., no skipping major versions).

##### **Steps:**

1. Backup:

```bash
sudo gitlab-backup create
sudo gitlab-ctl backup-etc
```

2. Update GitLab using the official Omnibus package:

```bash
sudo apt-get update
sudo apt-get install gitlab-ee
```

(or `gitlab-ce` if you're using the Community Edition)

3. Run reconfigure and check:

```bash
sudo gitlab-ctl reconfigure
sudo gitlab-ctl restart
sudo gitlab-rake gitlab:check SANITIZE=true
```

**GitLab Omnibus typically performs zero-downtime updates for minor/patch versions.**
For **major version upgrades**, brief downtime might be unavoidable during DB migrations.

#### **b) Use GitLab Zero Downtime Docs:**

[GitLab Zero Downtime Upgrade Guide](https://docs.gitlab.com/ee/update/#upgrading-without-downtime)

---

## **4️⃣ Tools and Best Practices to Protect GitLab**

| **Tool/Method**                                   | **Purpose**                   |
| ------------------------------------------------- | ----------------------------- |
| **Fail2Ban**                                      | Brute-force IP banning        |
| **rack\_attack**                                  | GitLab's built-in throttling  |
| **NGINX WAF (ModSecurity/OWASP CRS)**             | HTTP-level firewall           |
| **Reverse Proxy (Cloudflare / AWS ALB with WAF)** | Additional security layers    |
| **Regular Security Patches**                      | Keep GitLab updated           |
| **2FA Enforcement**                               | Prevent credential compromise |
| **Firewall / VPN Access**                         | Restrict access to known IPs  |
| **Security Audit (gitlab-ctl security-check)**    | Regularly check configs       |

---

## **5️⃣ Monitor for Suspicious Logins**

Enable audit logs in GitLab and review:

```bash
sudo cat /var/log/gitlab/gitlab-rails/audit_json.log
```

---

## **6️⃣ Optional: Use Fail2Ban with GitLab’s API Rate Limiting**

You can also limit API and Git operations with:

```ruby
gitlab_rails['rate_limit_requests_per_period'] = 100
gitlab_rails['rate_limit_period'] = 60
```

---

### **Summary Checklist**

| **Action**               | **Status** |
| ------------------------ | ---------- |
| 2FA Enabled              | ✅          |
| `rack_attack` Configured | 🔧         |
| `fail2ban` Setup         | 🔧         |
| Upgrade Plan in Place    | 🛠️        |
| Firewall/IP Whitelisting | 🔧         |
| Audit Logs Reviewed      | 🔍         |

