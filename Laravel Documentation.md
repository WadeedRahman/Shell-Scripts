
## 1. Update your server

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 2. Install PHP and required PHP extensions

Laravel typically requires PHP 8.1+ (check your Laravel version requirements).

Install PHP and extensions:

```bash
sudo apt install php php-cli php-fpm php-mysql php-xml php-mbstring php-curl php-zip php-bcmath php-tokenizer php-common php-pgsql unzip curl -y
```

Check PHP version:

```bash
php -v
```

---

## 3. Install MySQL Server

Install MySQL:

```bash
sudo apt install mysql-server -y
```

Start and enable MySQL:

```bash
sudo systemctl start mysql
sudo systemctl enable mysql
```

Secure MySQL installation:

```bash
sudo mysql_secure_installation
```

During setup, it will ask for:
- Set root password
- Remove anonymous users
- Disallow root login remotely
- Remove test database
- Reload privilege tables

✅ Recommend answering **yes** to all.

---

## 4. Create a MySQL database and user for Laravel

Login to MySQL:

```bash
sudo mysql -u root -p
```

Inside MySQL shell:

```sql
CREATE DATABASE your_database_name;
CREATE USER 'your_database_user'@'localhost' IDENTIFIED BY 'your_database_password';
GRANT ALL PRIVILEGES ON your_database_name.* TO 'your_database_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

---

## 5. Install Composer (PHP Dependency Manager)

Install Composer globally:

```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

Check Composer version:

```bash
composer --version
```

---

## 6. Clone or Upload your Laravel project

Go to `/var/www/`:

```bash
cd /var/www/
```

Clone your project from GitHub (or upload it):

```bash
sudo git clone https://github.com/your-username/your-laravel-project.git
```

## 7. Set correct permissions

Navigate into project directory:

```bash
cd /var/www/your-laravel-project
```
---

## 8. Install Laravel project dependencies

Run:

```bash
composer install 
```

---

## 9. Configure Laravel Environment

Copy `.env.example` to `.env`:

```bash
cp .env.example .env
```

Edit `.env` file:

```bash
nano .env
```

Set your database details:

```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database_name
DB_USERNAME=your_database_user
DB_PASSWORD=your_database_password
```

---

## 10. Generate Laravel Key

```bash
php artisan key:generate
```

---

## 11. Set up Nginx for Laravel

Install Nginx:

```bash
sudo apt install nginx -y
```

Create a new Nginx config file:

```bash
sudo nano /etc/nginx/sites-available/your-laravel-project-name
```

Add this basic Nginx configuration:

```nginx
server {
    listen 80;
    server_name your_domain_or_IP;

    root /var/www/your-laravel-project/public;
    index index.php index.html index.htm;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock; # change php8.1 if your PHP version is different
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
```

Save and exit.

Enable the site:

```bash
sudo ln -s /etc/nginx/sites-available/your-laravel-project /etc/nginx/sites-enabled/
```

Test Nginx configuration:

```bash
sudo nginx -t
```

Reload Nginx:

```bash
sudo systemctl reload nginx
```

---

## 12. Migrate Database (if needed)

If your Laravel project has migrations:

```bash
php artisan migrate
```

## 13. (Optional) Enable HTTPS (SSL) with Let's Encrypt

Install Certbot:

```bash
sudo apt install certbot python3-certbot-nginx -y
```

Get SSL certificate:

```bash
sudo certbot --nginx -d your_domain.com
```



