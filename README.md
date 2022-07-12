# Overview

The workspace consists of the following:

* WSL on laptops at work and home
* Code repositories on GitHub
* Autopilot cluster on GKE
* Container image library on Google Artifact Repository
* Databases on Amazon Lightsail instances, Google BigQuery and Azure Analysis Services
* Storages on Amazon S3 and Google Cloud Storage

Each WSL has Python, R, Julia and Rust installed locally, and uses Docker to run Jupyter Lab and Rstudio Server. For distributed computing on GKE, Python uses Dask; R uses Spark through Sparklyr; and Julia uses built-in SSHManager through Distributed.

Remote repositories on GitHub are cloned to WSL and synced to OneDrive through Rclone.

Google Artifact Repository hosts docker images for pods on GKE.

Using Docker, one Amazon Lightsail instance runs PostgreSQl and another runs Trino. For resource intensive queries, the Trino Helm chart can be installed through WSL for a deployment to GKE. Azure Analysis Services is for developing tabular models with Visual Studio for Power BI.

* Use one EC2 instance until the AWS savings plan expires. When it does expire, terminate the EC2 instance and launch Amazon Lightsail instances.

Local files can be first uploaded to storages and then loaded to databases.

## AWS

1. Add an IAM role for EC2 instances.

2. Create an elastic IP.

2. Launch an EC2 m6i.large instance with the IAM role and the elastic IP in the region `us-east-1`.

3. Add an inbound rule to open ports for PostgreSQL (5432) and Trino (8080).

4. Create a bucket `lee-psql` in S3.

5. Create a user and download security credentials.

## Google Cloud

1. Create a project with the name `project-lee-1`.

2. Create a GKE autopilot cluster with the name `autopilot-cluster-1` in the region `us-central1`.

3. Create an artifact registry for Docker with the name `docker` in the region `us-central1`.

4. Request additional quotas for CPUs (at least 128) and in-use IP addresses (at least 32) in the region `us-central1`.

5. Create a bucket `lee-bigquery` in GCS.

6. Create and download the service account key with an owner role.

## Azure

1. Create an Azure Analysis Services server with the name `azas1` in the location `East US`. During the set-up, create a stoarge account with the name `azas1backup` in the same location.

## Rclone

1. Download and extract Rclone on the local machine.

## Install WSL

1. Install `Terminal` from the Microsoft Store.

2. If no WSL has been installed before, open the Terminal and install the default distribution of WSL. If it is not the first time, skip this step.

```Shell
wsl --install
```

3. Check the installed distribution and unregister it.

```Shell
wsl --list
wsl --unregister Ubuntu
```

4. Install the default distribution of `Ubuntu`. Make sure the username is `ubuntu`.

```Shell
wsl --install -d Ubuntu
```

5. Log in and upgrade packages.

```Shell
wsl
sudo apt update
sudo apt upgrade
sudo apt autoremove
```

6. Log out and shut down WSL.

```Shell
logout
wsl --shutdown
```

## Install softwares and packages.

1. Download AWS and Google Cloud keys from the personal vault and the `prepare.sh` from OneDrive to the same folder on the local machine.

2. Copy the keys and the script from the local machine to WSL.

```Shell
wsl
cd /mnt/c/../path/to/downloaded/keys/and/script
cp us-east-1.pem key-aws.csv key-gcloud.json prepare.sh ~
```

3. Prepare for installations.

```Shell
cd ~
./prepare.sh # Add the SSH key displayed at the end to GitHub.
```

4. Add the SSH key on GitHub.

5. For the first time, run the wrapper script and then log out and back in.

```Shell
cd ~/github/scripts
bash install.sh
logout
```

6. To update each software, run individual scripts.

```Shell
cd ~/github/scripts/install
bash python.sh
```

6. To update each package, run individual scripts

```Shell
cd ~/github/scripts/packages
bash python.sh
```

## Set up Visual Studio Code

1. Install the following extensions in the VS Code on the local machine.

   * "Docker" from Microsoft
   * "ESLint" from Microsoft
   * "IntelliCode" from Microsoft
   * "Julia" from julialang
   * "Jupyter" from Microsoft
   * "Kubernetes" from Microsoft
   * "Python" from Microsoft
   * "Remote Development" from Microsoft
   * "rust-analyzer" from The Rust Programming Language

2. Log in to WSL, open the VS Code and install the extensions.

```Shell
wsl
code .
```

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

## Connect to the virtual machine from WSL

1. Set up ssh access to the virtual machine.

```Shell
cd ~/github/scripts
bash ssh-aws.sh
```

2. Log into the virtual machine with OpenSSH.

```Shell
ssh aws
```

3. Update system packages and reboot.

```Shell
sudo apt update
sudo apt upgrade
sudo reboot
```

## BigQuery

1. Start an interactive session.

```Shell
bq shell
```
