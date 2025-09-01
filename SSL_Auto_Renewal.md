
Here’s the script:

```bash
#!/bin/bash

# Shell script to check and renew Certbot SSL certificates for Apache

# Log file
LOG_FILE="/var/log/certbot-renew.log"

# Run certbot renew
echo "==== SSL Renewal Check Started on $(date) ====" >> $LOG_FILE
/usr/bin/certbot renew --quiet --deploy-hook "systemctl reload apache2" >> $LOG_FILE 2>&1

# Check exit status
if [ $? -eq 0 ]; then
    echo "SSL renewal check completed successfully on $(date)" >> $LOG_FILE
else
    echo "SSL renewal check failed on $(date)" >> $LOG_FILE
fi
echo "=============================================" >> $LOG_FILE
```

### Steps to Use:

1. Save this script:

   ```bash
   sudo nano /usr/local/bin/certbot-renew.sh
   ```

   Paste the script and save.

2. Make it executable:

   ```bash
   sudo chmod +x /usr/local/bin/certbot-renew.sh
   ```

3. Set up a **cron job** to run daily:

   ```bash
   sudo crontab -e
   ```

   Add this line:

   ```bash
   0 3 * * * /usr/local/bin/certbot-renew.sh
   ```

   👉 This runs the script every day at 3 AM.

---

🔹 Certbot only renews certificates that are **expiring within 30 days**, so this script is safe to run daily.
🔹 The `--deploy-hook "systemctl reload apache2"` ensures Apache reloads only if renewal happens.

