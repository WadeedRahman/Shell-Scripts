

# WordPress Security Hardening – Wordpress

## Overview

This document explains the security hardening measures applied to the `Wordpress` instance hosted on Ubuntu.
The goal is to reduce the attack surface, prevent unauthorized access, and protect sensitive areas of WordPress.

---

## Security Measures Implemented

### 1️⃣ **Protect Plugin Directory**

**File:** `/var/www/wordpress/wp-content/plugins/.htaccess`

```apache
<FilesMatch "\.(php|php\..*)$">
    Order Deny,Allow
    Deny from all
</FilesMatch>
```

**Purpose:**

* Prevent execution of any `.php` files in the `plugins` directory via HTTP.
* Stops attackers from exploiting insecure or abandoned plugins.

---

### 2️⃣ **Protect Uploads Directory**

**File:** `/var/www/wordpress/wp-content/uploads/.htaccess`

```apache
<FilesMatch "\.(php|php\..*)$">
    Order Deny,Allow
    Deny from all
</FilesMatch>
```

**Purpose:**

* Prevent PHP execution in the `uploads` folder.
* Stops attackers from uploading web shells or malicious scripts.

---

### 3️⃣ **Disable XML-RPC Access**

**File:** `/var/www/wordpress/.htaccess`

```apache
<Files xmlrpc.php>
Order Deny,Allow
Deny from all
Allow from 127.0.0.1
</Files>
```

**Purpose:**

* Blocks external access to `xmlrpc.php` (used in brute-force attacks and DDoS).
* Allows local-only use (127.0.0.1), e.g., for internal services if required.

---

### 4️⃣ **Disable WP-Cron External Access**

```apache
<Files wp-cron.php>
Order Allow,Deny
Allow from 127.0.0.1
</Files>
```

**Purpose:**

* Prevent external users from triggering `wp-cron.php`.
* Manual cron jobs or system cron (`crontab`) should handle scheduled tasks.

---

### 5️⃣ **Disable Access to Readme.html**

```apache
<Files readme.html>
Order Allow,Deny
Deny from all
</Files>
```

**Purpose:**

* Blocks access to `readme.html`, which exposes WordPress version and may help attackers fingerprint the site.

---

### 6️⃣ **Disable Directory Listing**

```apache
Options -Indexes
```

**Purpose:**

* Prevents attackers from browsing directories that don’t have an `index` file.

---

### 7️⃣ **Disable XML-RPC via DS-XML-RPC-API Section**

```apache
# BEGIN DS-XML-RPC-API
<Files xmlrpc.php>
order deny,allow
deny from all
</Files>
# END DS-XML-RPC-API
```

**Purpose:**

* This section is dynamically managed by WordPress plugins but also restricts XML-RPC access as an additional layer of security.

---

## 8️⃣ **wp-config.php Settings**

In `wp-config.php`:

```php
define('XMLRPC_REQUEST', false);
define('DISABLE_WP_CRON', true);
```

**Purpose:**

* `XMLRPC_REQUEST`: Prevents the current instance from using XML-RPC.
* `DISABLE_WP_CRON`: Disables WordPress's internal cron jobs to improve performance and security. Use `crontab` for scheduled tasks.

---

## Maintenance Notes

* **Backups:** Always back up `.htaccess` and `wp-config.php` before modifying.
* **WordPress Updates:** When WordPress updates or plugins regenerate `.htaccess`, re-verify your custom rules.
* **Testing:** After applying changes, test your website functionality and check for any broken features.

---

## Usage Instructions (For Future)

1. **Apply these `.htaccess` configurations** in any WordPress deployment to minimize risk.
2. **Use `DISABLE_WP_CRON` and set up server cron jobs** for better performance.
3. **Block XML-RPC unless absolutely needed** (e.g., Jetpack or external apps).
4. **Prevent file execution in `uploads` and `plugins` directories** to reduce RCE (Remote Code Execution) risk.
5. Keep WordPress core, themes, and plugins **up-to-date**.

---

## Disclaimer

These steps are part of a **security hardening practice** but do not guarantee complete security. Additional measures like WAF (Web Application Firewall), malware scanning, and monitoring should also be in place.

---

## Author
Wadeed
