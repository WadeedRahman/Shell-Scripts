To allow your `github-runner` user (or any user) to run commands with `sudo` on a Linux server, you need to **grant it sudo privileges**. Here’s how to do it safely and correctly:

---

## ✅ Step-by-Step: Grant `sudo` Access to `github-runner` User

---

### 🔹 Step 1: Switch to Root (if not already)

If you're logged in as a different user with sudo rights:

```bash
sudo -i
```

---

### 🔹 Step 2: Add User to the `sudo` Group

If you created the user with:

```bash
sudo adduser github-runner
```

You now grant sudo access with:

```bash
usermod -aG sudo github-runner
```

> This adds the user to the `sudo` group, which by default has sudo access on Ubuntu.

---

### 🔹 Step 3: Confirm It Worked

Switch to the `github-runner` user:

```bash
su - github-runner
```

Try running a sudo command:

```bash
sudo whoami
```

It should prompt for the `github-runner` password, and then return:

```
root
```

---

## ✅ Optional: Allow Passwordless `sudo` Access (Not Recommended for All Use Cases)

If the `github-runner` is a non-interactive automation account, you may want to let it run `sudo` without a password.

1. Open the sudoers file:

```bash
sudo visudo
```

2. Add this line **at the bottom**:

```
github-runner ALL=(ALL) NOPASSWD:ALL
```

3. Save and exit (in `nano`, press `Ctrl+X`, then `Y`, then `Enter`).

---

## 🔐 Security Warning

> Only do this if the server is **secured**, and the `github-runner` user is **not exposed** publicly. Avoid on multi-user or shared systems.

---

### ✅ Check the User's Groups

To confirm the user is now in the `sudo` group:

```bash
groups github-runner
```

You should see:

```
github-runner sudo
```

---
Creating User without password
sudo adduser --system --shell /bin/bash --group --disabled-password github-runner
