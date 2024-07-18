# Shell Script for running my project in Linux Environemnt 
#!/bin/bash

# Function to check if a process is running and print a message
check_process() {
  if pgrep -x "$1" > /dev/null
  then
    echo "$2 started successfully."
  else
    echo "Failed to start $2."
  fi
}

# Starting Frontend
cd ~/Desktop/React2/myapp
npm start &
sleep 5 # Wait for the server to start
check_process "node" "Frontend (React.js)"

# Starting Python Backend
cd ~/Desktop/Backend
source venv/bin/activate
export FLASK_APP=main.py
export FLASK_RUN_HOST=0.0.0.0
export FLASK_RUN_PORT=5000
flask run &
#We can easily run our flask application by following command 
#flask run --host=0.0.0.0 --port=5000

sleep 5 # Wait for the server to start
check_process "flask" "Backend (Flask)"

# Starting XAMPP (PHP, Apache, MySQL)
sudo /opt/lampp/lampp start &
sleep 5 # Wait for services to start
check_process "httpd" "XAMPP (Apache)"
check_process "mysqld" "XAMPP (MySQL)"
sudo /opt/lampp/manager-linux-x64.run &
sleep 5 # Wait for the manager to start
check_process "manager-linux-x64" "XAMPP Manager"

echo "All processes attempted to start."
