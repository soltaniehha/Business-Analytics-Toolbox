# Cloud Computing

`create-micro-instance.txt` script creates an f1-micro instance named **micro**.

`create-self-stopping-micro-instance.txt` script creates an f1-micro instance named **micro-auto** that will stop itself once the user is logged out to bring in cost-saving benefits.

## Instructions on Creating the Instance & RStudio Server Installation

Scripts above need to be run in the Cloud Shell. But before executing them you would need to update the "--project" argument. Simply replace `<PROJECT-ID>` with your project ID. Please note that project ID is not necessarily the same as project name.

1. Once the script is updated copy and paste it to your Cloud Shell. It will take a few minutes for the instance to be ready. You can confirm this by going to your GCP console > Menu > COMPUTE > Compute Engine. If the instance is ready it will be shown as green (unless it is stopped where it would be grey). If the instance was created but stopped because you didn't log in immediately you can simply select it and hit the START button.
2. Log in to your instance. From Compute Engine page you can click on SSH button. This will create a secure connection to your instance.
3. Run the following lines one at a time to install R & RStudio Server and answer yes to the questions (~ 5mins):
```
sudo apt update
sudo apt install r-base r-base-dev
sudo apt install gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb
sudo gdebi rstudio-server-1.2.1335-amd64.deb
```
4. By running the following command we will create a new user to access our RStudio Server (replace `<USERNAME>` with the username of your choice). You will need to provide a password, **keep it simple and write it down somewhere safe**:
```
sudo adduser <USERNAME>
```

## Log-in to RStudio
1. From Cloud Shell (and not the SSH window) run the following command, where `micro-auto` is your instance's name:
`gcloud compute ssh micro-auto --zone us-central1-a  -- -L 8080:localhost:8787`
2. Once you see `xxx@micro-auto:~$` at the prompt click on the **Web Preview** icon on the top right of Cloud Shell. You should be directed to a new webpage which is the login page of your RStudio Server. Use the username/password you just created to login.

**Note:** Since this is a self-stopping instance anytime you log out of the instance (by closing or exiting the Cloud Shell) your instance will "stop" automatically.

**Note:** Always save your work and push it to your git repository.

## Appendix
A cleaner version of the startup script that has been used in `create-self-stopping-micro-instance.txt` comes below:

```
#!/bin/bash
echo "boot $(date +'%Y%M%d-%H%m%S')" > /tmp/userdata.txt
(
echo "Starting..." >> /tmp/userdata.txt
sleep 600
while true; do
    logins=$(w | sed 1,2d | wc -l)
    echo "[ $(date +'%Y%M%d-%H%m%S') ] Number of logins: ${logins}" >> /tmp/userdata.txt   
    if [ "${logins}" -eq 0 ]; then
        shutdown -h now
    fi
    sleep 10
done
) &
```
