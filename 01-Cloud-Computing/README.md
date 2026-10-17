# Cloud Computing

`create-micro-instance.txt` script creates an e2-micro instance named **micro**.

`create-self-stopping-micro-instance.txt` script creates an e2-micro instance named **micro-auto** that will stop itself once the user is logged out to bring in cost-saving benefits.

Both instances run Debian 13 (the latest `debian-13` image is picked automatically).

The scripts use zone `us-east1-b`. If you get an error saying the zone doesn't have enough resources, change the zone to `us-east1-c` or `us-east1-d` in the script and in the commands below.

## Creating the Instance

Scripts above need to be run in the Cloud Shell.

1. Copy and paste the script to your Cloud Shell. It will take less than a minute for the instance to be ready. You can confirm this by going to your GCP console > Menu > COMPUTE > Compute Engine. If the instance is ready it will be shown as green (unless it is stopped where it would be grey). If the instance was created but stopped because you didn't log in immediately you can simply select it and hit the START button.
2. Log in to your instance. From Compute Engine page you can click on SSH button. This will create a secure connection to your instance. Alternatively, from Cloud Shell run the following command, where `micro-auto` is your instance's name:

> `gcloud compute ssh micro-auto --zone us-east1-b`

**Note:** the first time you connect with `gcloud compute ssh` you will be asked for an SSH key passphrase. Just hit Enter twice; it is not necessary.

## Starting & Stopping the Instance
If your instance is stopped you would need to "start" it before connecting to it. You can do it in two simple ways:
  * Go to your Compute Engine page, select the instance and click Start.
  * From the Cloud Shell run the following command to start an instance called `micro-auto`:

> `gcloud compute instances start micro-auto --zone us-east1-b`

To stop an instance yourself, use the Stop button or:

> `gcloud compute instances stop micro --zone us-east1-b`

**Note:** Since `micro-auto` is a self-stopping instance anytime you log out of the instance (by closing the SSH window or exiting the Cloud Shell) your instance will "stop" automatically. It checks every 10 seconds, starting 10 minutes after the instance boots. The `micro` instance keeps running (and billing) until you stop it.

**Note:** Once you are done with an instance, delete it so you are not charged for its disk:

> `gcloud compute instances delete micro-auto --zone us-east1-b`

## Appendix
`create-self-stopping-micro-instance.txt` first writes a startup script to `startup.sh` and then creates the instance with it. On every boot the script waits 10 minutes, then checks every 10 seconds whether anyone is logged in (`w -h`). When nobody is, it runs `shutdown -h now`, which stops the instance. Its log is in `/tmp/userdata.txt` on the instance.
