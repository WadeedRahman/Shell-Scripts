

##  Recommended Way: Manual Installation of phpMyAdmin (Compatible with PHP 7.1)

### 🔧 Step-by-Step Guide

---

### 1. **Download Compatible phpMyAdmin Version**

The last version to officially support PHP 7.1 is **phpMyAdmin 4.9.7**.

```bash
cd /var/www/html
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz
```

---

### 2. **Extract and Rename**

```bash
tar -xvzf phpMyAdmin-4.9.7-all-languages.tar.gz
mv phpMyAdmin-4.9.7-all-languages phpmyadmin
rm phpMyAdmin-4.9.7-all-languages.tar.gz
```

---

### 3. **Set Permissions**

```bash
sudo chown -R www-data:www-data /var/www/html/phpmyadmin
```

---

### 4. **Create `config.inc.php` File**

```bash
cd /var/www/html/phpmyadmin
cp config.sample.inc.php config.inc.php
```

Open it in a text editor:

```bash
nano config.inc.php
```

Find this line:

```php
$cfg['blowfish_secret'] = ''; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */
```

Replace it with a random string (16+ chars):

```php
$cfg['blowfish_secret'] = 'myrandomlongsecretkey123!@#';
```

Save and exit (Ctrl + X, then Y, then Enter).

---

### 5. **Enable Required PHP Extensions**

Make sure the following PHP 7.1 extensions are installed:

```bash
sudo apt install php7.1-mbstring php7.1-zip php7.1-gd php7.1-mysql php7.1-xml php7.1-curl
sudo systemctl restart apache2
```

---

### 6. **Access phpMyAdmin**

Open your browser and go to:

```
http://your-server-ip/phpmyadmin
```

Use your MySQL credentials (`root` and password) to log in.

---

### ✅ (Optional) Add Apache Alias (if needed)

If phpMyAdmin doesn’t load properly at `/phpmyadmin`, you can create an Apache alias:

```bash
sudo nano /etc/apache2/conf-available/phpmyadmin.conf
```

Paste this:

```apache
Alias /phpmyadmin /var/www/html/phpmyadmin

<Directory /var/www/html/phpmyadmin>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
```

Then enable it:

```bash
sudo a2enconf phpmyadmin
sudo systemctl reload apache2
```

---
