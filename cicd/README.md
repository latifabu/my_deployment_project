# CICD Using Concourse 

### What is Concourse  
#### ![concourse](https://miro.medium.com/max/1024/0*3LcW1HHfWBzDUy7S.png) 
- Concourse is wrriten in GoLang
- Fully open sourced
- Uses postgress as a backend 
- Uses containers to run tasks 
#### Why Concourse and not Jenkins
- Concourse is not at plugin dependant
- Makes use of containers and therefore uses less sustem resources and the use of microservices.
- Highly available
- No strcit isolation when running tasks/jobs
- Just write everything in yaml thus makeing code easier to replicate 
-  Wehook is not necessary to trigger a job
### Install Concourse CI on Ubuntu 22.04 using Docker and docker compose


- Setup: remember concourse runs on port 8080 so when creating ec2 instance add port 8080 to your outbound rules
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
If steps above do not work follow the official documentation:
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
- run `sudo docker-compose up -d`
The follwing should appear 

![docker_container](https://i.imgur.com/xZVtRcf.png)

- Create IP address and associate it with the EC2 instance.
- Use that IP in when setting up the docker compose to save changing the IP daily
![elastic_ip](https://i.imgur.com/c7IWUI1.png)


Next install Fly
- Next, install the fly CLI by downloading it from the web UI and login to your local Concourse as the test user:
   ```
   $ curl 'http://<public_ip>):8080/api/v1/cli?arch=amd64&platform=darwin' -o fly \
    && chmod +x ./fly && mv ./fly /usr/local/bin/ 
    ```
Then:

    ``` 
    $ fly -t tutorial login -c http://localhost:8080 -u test -p test
    logging in to team 'main' 

    ```

If running on localhost do the following:
![imgur_link](https://i.imgur.com/YnhY1ma.png)


#### Test server with a hello world pipeline:
- create yaml file ` sudo nano hello-world.yml` 
- add the following:
```
---
jobs:
- name: hello-world-job
  plan:
  - task: hello-world-task
    config:
      # Tells Concourse which type of worker this task should run on
      platform: linux
      # This is one way of telling Concourse which container image to use for a
      # task. We'll explain this more when talking about resources
      image_resource:
        type: registry-image
        source:
          repository: busybox # images are pulled from docker hub by default
      # The command Concourse will run inside the container
      # echo "Hello world!"
      run:
        path: echo
        args: ["Hello world!"]
```

- run the pipeline with `fly -t tutorial set-pipeline -p hello-world -c hello-world.yml`
- pipelines are paused when created, unpause with ` fly -t tutorial unpause-pipeline -p hello-world`
- trigger the job and watch it run with `fly -t tutorial trigger-job --job hello-world/hello-world-job --watch`
- The result should be the following:
![imgur_hello_wordl](https://imgur.com/cb9ROqJ.png)


