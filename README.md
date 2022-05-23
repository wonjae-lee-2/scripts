# How to install software on the new remote machine

## Connect to the remote machine

1. Open Powershell on the local machine.

2. Create the OpenSSH `config` file on the local machine.

```Powershell
New-Item `
   -Force `
   -Path "~\.ssh" `
   -Name "config" `
   -ItemType "file" `
   -Value (
      "Host *`n  ServerAliveInterval 600`n  ServerAliveCountMax 6`n" +
      "Host aws`n  Hostname ec2-3-83-6-11.compute-1.amazonaws.com`n  User ubuntu`n  IdentityFile ~\.ssh\us-east-1.pem`n"
   )
```

3. Delete the OpenSSH `known_hosts` file on the local machine.

```Powershell
rm ~\.ssh\known_hosts
```

4. Log into the remote machine with OpenSSH.

```Powershell
ssh aws
```

## Get install scripts.

1. Set a password for the default user.

```Shell
sudo passwd ubuntu
```

2. Upgrade system packages and reboot.

```Shell
sudo apt update
sudo apt upgrade
sudo reboot
```

3. Wait for a minute and log into the remote machine.

4. Install Git and generate a SSH key.

```Shell
sudo apt install git
ssh-keygen -t ed25519 # Select the default path.
cat ~/.ssh/id_ed25519.pub
```

5. Add the SSH key on GitHub.

6. Create directories.

```Shell
mkdir ~/downloads ~/github ~/venv
```

6. If the GitHub repo is out-dated, copy from the local machine.

```Shell
scp -r C:\Users\wonja\OneDrive\backup\github\* aws:~/github # Execute on the local machine.
```

7. If the GitHub repo is up-to-date, clone the `scripts` repository.

```Shell
git clone git@github.com:wonjae-lee-2/scripts ~/github/scripts
```

8. Create a `password` file.

```Shell
cd ~/github/scripts
echo $PASSWORD | tee password # Replace $PASSWORD with a new password of your choice.
```

## Run install scripts

1. Run install scripts for Python, R, RStudio, PostgreSQL, MySQL, Julia, Node.js, Rust, Docker and Rclone.

2. Log out and then log in again after installing Node.js, Rust and Docker.

## Set up a password for Jupyter Lab when it is run for the first time.

1. Activate a Python virtual environment.

```Shell
. ~/venv/python-3.10.4/bin/activate
```

2. Start Jupyter Lab and copy the login token.

```Shell
jupyter lab --no-browser --ip=0.0.0.0 --port=8888
```

3. Type `~C` and then `-L 8787:localhost:8787` to request local forward.

4. Go to `localhost:8787` in the browser on the local machine.

5. Set up a password with the login token.

## Log into RStudio Server.

1. Use the username and password of the default user of the remote machine.

## Log into PostgreSQL and MySQL remotely.

1. Use the username `ubuntu` with password to log in remotely.

## Copy and sync the github folder with Rclone and OneDrive.

1. If OneDrive is out-dated, sync files from sub-folders to OneDrive.

```Shell
rclone sync --progress ~/github/islr2 onedrive:backup/github/islr2
rclone sync --progress ~/github/kaggle onedrive:backup/github/kaggle
```

2. Clear the github folder.

```Shell
rm -fr ~/github/*
```

3. Copy files from OneDrive to the github folder.

```Shell
rclone copy onedrive:backup/github ~/github 
```

4. Add a line to `.profile` for syncing in the background.

```Shell
echo "~/github/scripts/rclone-sync.sh &" >> ~/.profile
```

5. Log out and log in again to activate `.profile`.

## Set up Visual Studio Code

1. Install the following extensions on the local machine.

   * "Docker" from Microsoft
   * "ESLint" from Microsoft
   * "IntelliCode" from Microsoft
   * "Julia" from julialang
   * "Jupyter" from Microsoft
   * "Python" from Microsoft
   * "Remote-Containers" from Microsoft
   * "Remote-SSH" from Microsoft
   * "Rust" from The Rust Programming Language

2. Connect to the virtual machine and install the extensions.

3. Open the VS Code settings file.

```Shell
nano ~/.vscode-server/data/Machine/settings.json
```

4. Add the following settings.

```JSON
{
   "python.defaultInterpreterPath": "/home/ubuntu/venv/python-${PYTHON_VERSION}/bin/python",
   "julia.executablePath": "/opt/julia-${JULIA_VERSION}/bin/julia",
   "julia.environmentPath": "/home/ubuntu/venv/julia-${JULIA_VERSION}/",
   "rust-client.rustupPath": "/home/ubuntu/.cargo/bin/rustup"
}
```
