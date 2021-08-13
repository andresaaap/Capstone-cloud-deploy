# Capstone-cloud-deploy

### Pre-requirement
-[Install Jenkins and login Jenkins](https://github.com/davincizhao/Jenkins_Pipelines_on_AWS/blob/master/README.md)
- Install epel
```
sudo amazon-linux-extras install epel
```
- Install git,tidy,docker
Enable docker daemon and allow jenkins to connect to docker engine.
'''
systemctl start docker
chown jenkins /var/run/docker.sock
'''
