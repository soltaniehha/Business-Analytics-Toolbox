# Cloud Computing

`create-micro-instance.txt` script creates an f1-micro instance named **micro**.

`create-self-stopping-micro-instance.txt` script creates an f1-micro instance named **micro-auto** that .

A cleaner version of the startup script that has been used comes below:

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
