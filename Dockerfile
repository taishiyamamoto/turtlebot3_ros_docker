FROM nvidia/cudagl:10.2-runtime-ubuntu18.04

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y lsb-release language-pack-en

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'	&& \
	apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update && \
	apt install -y 	ros-melodic-desktop-full \ 
					python-rosdep python-rosinstall && \
	rosdep init && rosdep update
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
	bash -c "source ~/.bashrc"

RUN apt-get update && \
	apt-get install -y 	tmux \
						ipython \
						python \
						git \
						wget \
						tar \
						vim \
						ipython \
						python \
						python-pip
#RUN apt-get install -y libeigen3-dev
#RUN apt-get install -y libboost-all-dev
RUN apt-get install --allow-unauthenticated -y 	rviz ros-melodic-jsk-rviz-plugins \
												python-wstool \ 
												python-rosdep \ 
												python-rospkg \ 
												python-rosinstall \ 
												python-catkin-tools

RUN mkdir -p /root/catkin_ws/src && \
	 cd /root/catkin_ws && catkin init && \
	 rm /bin/sh && ln -s /bin/bash /bin/sh
RUN cd /root/catkin_ws/src && \
	git clone https://github.com/ROBOTIS-GIT/turtlebot3.git && \
	git clone https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git && \
	git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git && \
	git clone https://github.com/ros-planning/navigation.git
RUN source /opt/ros/melodic/setup.bash && \
	cd /root/catkin_ws && \
	rosdep install --from-paths src/ --ignore-src --rosdistro $ROS_DISTRO -y && \
	export CMAKE_PREFIX_PATH=~/catkin_ws/devel:/opt/ros/$ROS_DISTRO

RUN cd /root/catkin_ws && source /opt/ros/melodic/setup.bash && catkin build
RUN rm -rf /var/lib/apt/lists/* && \
	echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
    echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
	echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc