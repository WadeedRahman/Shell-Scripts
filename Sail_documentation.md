
---

# General Steps

1. **Docker Installation and Adding User to Docker Group**
    - Verify it using `docker version` which shows both Docker client and Docker server.

2. **Clone the Project and Change the Branch**

3. **Check and Modify `.env`**

4. **Modify the `.bashrc` in Home Directory and Source it.**

5. **Stop the MySQL or Other Services such as Apache2 if Used**

6. **Run Container using Sail**

7. **Generate Key, Migrate, and Optimize using Sail**

---

# Docker Installation

**Link for Documentation:** [Docker Engine Install on Debian](https://docs.docker.com/engine/install/debian/)

## Commands for Docker Installation:

1. **Add Docker's Official GPG Key:**
    ```bash
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    ```

2. **Add the Repository to Apt Sources:**
    ```bash
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    ```

3. **Install Docker:**
    ```bash
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    ```

4. **Verify Docker Installation:**
    ```bash
    docker --version
    sudo systemctl status docker
    ```

5. **Add User to Docker Group:**
    ```bash
    sudo usermod -aG docker ${USER}
    ```

6. **Activate Changes to Groups:**
    ```bash
    newgrp docker
    ```

7. **Verify User is Added to Docker Group:**
    ```bash
    groups ${USER}
    ```

8. **Verify that User is Added to the Docker Group:**
    ```bash
    docker version 
    # if this command shows both client and server, the user is successfully added
    ```

---

# Project Setup

1. **Navigate to the Project Directory and Clone the Repository:**
    ```bash
    cd /var/www
    git clone https://github.com/your-username/your-laravel-project.git
    ```

2. **Navigate into the Project Directory:**
    ```bash
    cd your-laravel-project
    ```

3. **Install Composer if Not Already Installed:**
    ```bash
    composer install
    ```

4. **Configure the Environment File:**
    ```bash
    nano .env
    # Add the credentials or include the .env
    ```

5. **Remove the `APP_KEY` Entry from the `.env` File:**
    ```bash
    nano .env
    # Delete old key and set APP_KEY=
    ```

---
**Link for Documentation:** [Laravel Sail Official Documentation](https://laravel.com/docs/11.x/sail)

# Configure Sail Alias

1. **Add Sail Alias to `.bashrc` in Home Directory:**
    ```bash
    nano ~/.bashrc
    # Add the line: 
    alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
    ```

2. **Source the `.bashrc` File:**
    ```bash
    source ~/.bashrc
    ```

---

# Check MySQL Service if Running

1. **Stop MySQL Service:**
    ```bash
    sudo service mysql stop 
    sudo service mysql status
    ```

---

# Start Sail Containers

1. **Start Sail Containers in Detached Mode:**
    ```bash
    sail up -d
    ```

---

# Laravel Sail Commands

1. **Generate Application Key:**
    ```bash
    sail artisan key:generate
    ```

2. **Run Database Migrations:**
    ```bash
    sail artisan migrate
    ```

3. **Optimize the Application:**
    ```bash
    sail artisan optimize
    ```

---

