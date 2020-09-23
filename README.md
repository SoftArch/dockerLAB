# dockerLAB

docker LAB is a dind (docker in docker) sample.
It includes HTML5 VNC interface to access LXDE desktop environment.
Visual Studio Code added for writing Dockerfile, Docker Compose and some code samples.

Include;
+ Visual Studio Code

#### Pull and Run Docker
  ```bash
  docker run -it --rm --privileged -p 6080:80 softarch/docker-lab
  ```
 
#### Connect VNC with browser
Open [http://localhost:6080/](http://localhost:6080/)

#### Start Docker Service
  Docker service start command
  ```bash
  service docker start
  ```
