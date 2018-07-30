FROM ros:indigo

RUN apt-get update && apt-get install -y \
build-essential \
openssh-server

RUN mkdir -p ~/catkin_ws/src/JackalNavigation

RUN /bin/bash -c '. /opt/ros/indigo/setup.bash; cd ~/catkin_ws/src && catkin_init_workspace'
RUN /bin/bash -c '. opt/ros/indigo/setup.bash; cd ~/catkin_ws && catkin_make'
RUN git clonehttps://github.com/HassamSheikh/JackalNavigation.git ~/catkin_ws/src/JackalNavigation
RUN cd ~/catkin_ws/src/JackalNavigation && git pull origin master

RUN /bin/bash -c '. /opt/ros/indigo/setup.bash;cd ~/catkin_ws/src/ && catkin_create_pkg jackal_navigation geometry_msgs rospy'
RUN cp -r ~/catkin_ws/src/JackalNavigation/JackalNavigation/* ~/catkin_ws/src/jackal_navigation/
RUN chmod +x ~/catkin_ws/src/jackal_navigation/scripts/*
RUN chmod +x ~/catkin_ws/src/JackalNavigation/JackalNavigation/scripts/*

# Robot IP address. The port is 11311 do not change it.
ENV ROS_MASTER_URI=http://192.168.10.102:11311
# Your device IP address.
ENV ROS_IP=192.168.10.104

CMD ["roscore"]
