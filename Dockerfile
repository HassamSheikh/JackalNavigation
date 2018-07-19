FROM ros:indigo

RUN apt-get update && apt-get install -y \
build-essential \
openssh-server

RUN mkdir -p ~/catkin_ws/src/JackalNavigation

RUN /bin/bash -c '. /opt/ros/indigo/setup.bash; cd ~/catkin_ws/src && catkin_init_workspace'
RUN /bin/bash -c '. opt/ros/indigo/setup.bash; cd ~/catkin_ws && catkin_make'
RUN git clone https://github.com/siavash-khodadadeh/JackalNavigation.git ~/catkin_ws/src/JackalNavigation
RUN cd ~/catkin_ws/src/JackalNavigation && git pull origin master

RUN /bin/bash -c '. /opt/ros/indigo/setup.bash;cd ~/catkin_ws/src/ && catkin_create_pkg jackal_navigation geometry_msgs rospy'
RUN cp -r ~/catkin_ws/src/JackalNavigation/JackalNavigation/* ~/catkin_ws/src/jackal_navigation/
RUN chmod +x ~/catkin_ws/src/jackal_navigation/scripts/*

ENV ROS_MASTER_URI=http://10.42.0.68:11311
ENV ROS_IP=172.17.0.2

CMD ["roscore"]

