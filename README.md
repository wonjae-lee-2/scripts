# How to install software on the new remote machine

## AWS

1. Launch an EC2 m6i.large instance.

## Google Cloud

1. Create a GKE cluster in Autopilot mode. (Increase quotas for in-use IP addresses and CPUs.)

2. Create and download the service account key.

# Rclone

1. Download and extract Rclone on the local machine.

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

4. Copy the service account key out of the personal vault.

5. Copy the service account key from the local machine to the remote machine.

```Shell
scp C:\path\to\the\key aws:~
```

6. Log into the remote machine with OpenSSH.

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
echo PASSWORD_FILE | tee password # Replace PASSWORD_FILE with a new password of your choice.
```

## Run install scripts.

1. Run install scripts for AWS CLI, gcloud CLI, Python, R, RStudio, Docker, Spark, Julia, Node.js, Rust, PostgreSQL and Rclone.

2. Log out and then log in again after installing gcloud CLI, Docker, Julia, Node.js and Rust.

## Start docker containers.

1. Create the `compose.yml` file.

```Shell
cd ~/github/scripts
sed "s/PASSWORD_FILE/$(cat password)/g" template.yml > compose.yml
```

2. Build containters.

```Shell
docker compose build
```

3. Run containers.

```Shell
docker compose run --rm --service-ports python # Replace python with r, julia, psql or mysql
```

3. For the python jupyter lab, press `shift` + `` ` `` + `c` and then type `-L 8888:localhost:8888` to request local forward. Replace the port number `8888` with `8787` or `1234` for the R and Julia containers.

4. For the python jupyter lab, copy the token dispalyed on the virtual machine and go to `localhost:8888` in the browser of the local machine.  Replace the port number `8888` with `8787` or `1234` for the R and Julia containers.

5. Run Pluto in a new Julia container.

```Shell
# Type below after you build the Julia image.
docker compose run --rm --service-ports julia /pluto.sh
```

6. Start a bash shell in the running PostgreSQL container.

```Shell
# Type below after you start the PostgreSQL container.
docker compose exec -u postgres psql bash
# Use the username 'postgres' and the password from 'PASSWORD_FILE' to connect to the database remotely.
```

7. Start a bash shell in the running MySQL container.

```Shell
# Type below after you start the MySQL container.
docker compose exec mysql bash
# Use the username 'root' and the password from 'PASSWORD_FILE' to connect to the database remotely.
```

## Log into RStudio Server.

1. For the container, Use the username `rstudio` and the password generated from the container.

2. For the installed version, use the username `ubuntu` and password of `ubuntu`.

## Remotely log into PostgreSQL and MySQL installed on the virtual machine (not docker containers).

1. Use the username `ubuntu` with the password from PASSWORD_FILE to log in remotely.

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

## 
