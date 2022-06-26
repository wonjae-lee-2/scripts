# How to install software on a new remote machine.

## AWS

1. Add an IAM role for EC2 instances.

2. Create an elastic IP.

2. Launch an EC2 m6i.large instance with the IAM role and the elastic IP.

3. Add an inbound rule to allow PostgreSQL connections.

4. Create a user and download security credentials.

## Google Cloud

1. Create a project.

2. Create a GKE cluster in the standard mode. (Increase quotas for C2 CPUs.)

3. Create an artifact registry for Docker.

4. Create and download the service account key with an owner role.

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

4. Download AWS and Google Cloud keys from the personal vault to the same folder on the local machine.

5. Copy the keys from the local machine to the remote machine.

```Shell
cd C:\path\to\downloaded\files
scp key-aws.csv key-gcloud.json aws:~
```

6. Log into the remote machine with OpenSSH.

```Powershell
ssh aws
```

## Get install scripts.

1. Upgrade system packages and reboot.

```Shell
sudo apt update
sudo apt upgrade
sudo reboot
```

2. Wait for a minute and log in again to the virtual machine.

3. Install Git and generate a SSH key.

```Shell
sudo apt install git
ssh-keygen -t ed25519 # Select the default path.
cat ~/.ssh/id_ed25519.pub
```

4. Add the SSH key on GitHub.

5. If the GitHub repo is up-to-date, clone the `scripts` and `docker` repository.

```Shell
git clone git@github.com:wonjae-lee-2/scripts ~/github/scripts
git clone git@github.com:wonjae-lee-2/docker ~/github/docker
```

6. If the GitHub repo is out-dated, copy from the local machine.

```Shell
scp -r C:\Users\wonja\OneDrive\backup\github\* aws:~/github # Execute on the local machine.
```

7. Prepare for installations.

``Shell
cd ~/github/scripts
./prepare.sh
```

## Install softwares and packages.

1. For the first time, run the wrapper script.

```Shell
cd ~/github/scripts
./install.sh
```

2. To update each software, run individual scripts.

```Shell
cd ~/github/scripts/install
./python.sh
```

3. To update each package, run individual scripts

```Shell
cd ~/github/scripts/packages
./python.sh
```

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
   * "Kubernetes" from Microsoft
   * "Python" from Microsoft
   * "Remote-Containers" from Microsoft
   * "Remote-SSH" from Microsoft
   * "rust-analyzer" from The Rust Programming Language

2. Connect to the virtual machine and install the extensions.

3. Open the VS Code settings file.

```Shell
nano ~/.vscode-server/data/Machine/settings.json
```

4. Add the following settings. Enter the full python version for `python.defaultInterpreterPath`. Run `juliaup status` to get the Julia version for `julia.executablePath`. Enter the full Julia version for `julia.environmentPath`.

```JSON
{
   "python.defaultInterpreterPath": "/home/ubuntu/venv/python/${PYTHON_FULL_VERSION}/bin/python",
   "julia.executablePath": "/home/ubuntu/.julia/juliaup/julia-${JULIA_STATUS_VERSION}/bin/julia",
   "julia.environmentPath": "/home/ubuntu/venv/julia/${JULIA_FULL_VERSION}",
   "rust-client.rustupPath": "/home/ubuntu/.cargo/bin/rustup"
}
```

## Log into RStudio Server.

1. For the container, Use the username `rstudio` and the password generated from the container.

2. For the installed version, use the username `ubuntu` and password of `ubuntu`.

## Remotely log into PostgreSQL and MySQL installed on the virtual machine (not docker containers).

1. Use the username `ubuntu` with the password from PASSWORD_FILE to log in remotely.
