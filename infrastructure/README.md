# CICD 

## Using Concourse 
#### ![concourse](https://miro.medium.com/max/1024/0*3LcW1HHfWBzDUy7S.png) 

- Continous Intergration/ Continous Deployment (CICD)

### Install Concourse CI on Ubuntu 22.04 using Docker and docker compose

1)
``` 
# Standard server update to configure the server 
$ sudo apt-get update

# Will install packages to allow `apt` to use a repoistory over HTTPS

$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```
2) Add Docker's official GPG key:
   
``` 
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

3. Use the following command to set up the repository:

```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
### Install Docker Engine
1. Update the `apt` package index:
``` 
sudo apt-get update 
```
2. Install the latest version and docker compose with

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin 
```
3. Verifify installtion with
```
sudo docker run hello-world
```
If steps above do not work follow the official documentation 
https://docs.docker.com/engine/install/ubuntu/


### Concourse section
Install docker compose
- `curl -O https://concourse-ci.org/docker-compose.yml`

Once the docker-compose has been installed edit it with 
- ` sudo nano docker-compose.yml`
or `sudo vim docker-compose.yml`

Change external url to your own url 
(i.e your own oublic IP addresss if you are running your server on the cloud)
- the docker compose yml file should look like the following
![docker_compose](https://i.imgur.com/ktxVdwo.jpg)
