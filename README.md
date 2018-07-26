# JackalNavigation

This is a repository for controlling a [Jackal Robot](https://www.clearpathrobotics.com/jackal-small-unmanned-ground-vehicle/).


### Dependencies
This code requires the following:
* docker

### Setup
Please make sure that the robot and the system on which you run the code are connected to the same network 
(The network name is yellow in case of [our lab](http://hector.cs.ucf.edu/robotics/)). You can use [this link](http://go.pardot.com/e/92812/1f4hmqP/7c4wh/246983157) for connecting Jackal to a network.
* Clone the repository at first.
* Run this command to build the docker.
```
sudo docker build -t jackal_navigation .
```

* If you are not creating the access point on your own computer, run this command:
```
sudo docker run --network=host jackal_navigation
```
* If you want to create an access point, run thiese commands instead:
```
sudo ip addr add 10.12.0.117/21 dev docker0
sudo docker run -p 10.12.0.117:80:80 jackal_navigation
```

* Open another terminal (Or you can run the docker in detached mode. In order to do that just add -d flag to docker run command.)

* Get the container id by running this command:
```
sudo docker ps
```

* In the list of all running containers which is returned by this command, copy the container id which corresponds to container name jackal_navigation.

* Run these commands. {container-id} is the id that you got from the previous step.
```
sudo docker exec -it {container-id} bash
source ~/catkin_ws/devel/setup.bash
rosrun jackal_navigation controller.py 
```

Control the robot with arrow keys.

### Contact
To ask questions or report issues, please open an issue on the [issues tracker](https://github.com/siavash-khodadadeh/JackalNavigation/issues).
