# Overview

The workspace consists of the following:

* c2-standard-4 Spot VM on Google Cloud
* Code repositories on GitHub
* Autopilot cluster on GKE
* Container image library on Google Artifact Repository
* Databases on the Spot VM, Google BigQuery and Azure Analysis Services
* Storages on Google Cloud Storage

The Spot VM has Python, R, Julia and Rust installed, and uses Docker to run Jupyter Lab and Rstudio Server. For distributed computing on GKE, Python uses Dask; R uses Spark through Sparklyr; and Julia uses built-in SSHManager through Distributed.

Remote repositories on GitHub are cloned to WSL and synced to OneDrive through Rclone.

Google Artifact Repository hosts docker images for pods on GKE.

Using Docker, the Spot VM runs PostgreSQl and Trino. For resource intensive queries, the Trino Helm chart can be installed from the Spot VM for a deployment to GKE. Python on the Spot VM can access the Azure Analysis Services through .NET and pythonnet package.

Local files can be first uploaded to storages and then loaded to databases.

## Google Cloud

1. Create a project with the name `project-lee-1`.

2. Create a c2-standard-4 Spot VM with the name `instance-1` and OS `ubuntu` and disk space `60GB` from the `instance-1` template.

3. Reserve an external static ip address and attach it to `instance-1`.

4. Create firewall rules to open tcp ports for PostgreSQL (5432) and Trino (8080).

5. Create a GKE autopilot cluster with the name `autopilot-cluster-1` in the region `us-central1`.

6. Create an artifact registry for Docker with the name `docker` in the region `us-central1`.

7. Request additional quotas for CPUs (at least 128) and in-use IP addresses (at least 32) in the region `us-central1`.

8. Create a bucket `lee-bigquery` and `lee-postgres` in GCS.

9. Create and download the service account key with an owner role.

## Rclone

1. Download and extract Rclone on the local machine.

## Connect to the Spot VM through OpenSSH.

1. Open Powershell on the local machine.

2. Generate an SSH key pair on the local machine and copy the public key.

```Shell
ssh-keygen -t ed25519 # Create in the default location without a password.
cat ~/.ssh/id_ed25519.pub
```

3. Add the public key to the Metadata tab in the Compute Engine. Replace the username after space towards the end with `ubuntu`.

4. Create the OpenSSH `config` file on the local machine.

```Powershell
New-Item `
   -Force `
   -Path "~\.ssh" `
   -Name "config" `
   -ItemType "file" `
   -Value (
      "Host *`n  ServerAliveInterval 600`n  ServerAliveCountMax 6`n" +
      "Host gcp`n  Hostname 34.172.239.100`n  User ubuntu`n  IdentityFile ~\.ssh\id_ed25519`n"
   )
```

5. Delete the OpenSSH `known_hosts` file on the local machine.

```Shell
rm ~\.ssh\known_hosts
```

6. Log into the remote machine with OpenSSH.

```Shell
ssh gcp
```

7. Set the password for the user `ubuntu`.

```Shell
sudo passwd ubuntu
```

8. Update installed packages.

```Shell
sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo reboot
```

## Install softwares and packages.

1. Download the Google Cloud key from the personal vault and the `prepare.sh` from OneDrive to the same folder on the local machine.

2. Download all the DLL files of the latest `Microsoft.AnalysisServices.AdomdClient.NetCore.retail.amd64` from the NuGet Package Explorer. You can download the files from the explorer if you double-click on them.

3. Copy the files from the local machine to Spot VM.

```Shell
scp gcloud-key.json prepare.sh *.dll gcp:~
```

4. Log into the Spot VM and prepare for installations.

```Shell
ssh gcp
cd ~
bash prepare.sh # Add the SSH key displayed at the end to GitHub.
```

5. Add the SSH key on GitHub.

6. For the first time, run the wrapper script and then log out and back in.

```Shell
cd ~/github/scripts
bash install.sh
logout
```

7. To update each software, run individual scripts.

```Shell
cd ~/github/scripts/install
bash python.sh
```

8. To update each package, run individual scripts

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

2. Connect the VS Code to the Spot VM and install the extensions there

3. Open the VS Code settings file.

```Shell
nano ~/.vscode-server/data/Machine/settings.json
```

4. Add the following settings. Enter the full python version for `python.defaultInterpreterPath`. Enter the full Julia version for `julia.environmentPath`.

```JSON
{
   "python.defaultInterpreterPath": "/home/ubuntu/venv/python/${PYTHON_FULL_VERSION}/bin/python",
   "julia.executablePath": "/home/ubuntu/.julia/juliaup/bin/julia",
   "julia.environmentPath": "/home/ubuntu/venv/julia/${JULIA_FULL_VERSION}",
   "rust-client.rustupPath": "/home/ubuntu/.cargo/bin/rustup"
}
```

## BigQuery

1. Start an interactive session.

```Shell
bq shell
```
