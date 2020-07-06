# turtlebot3_ros_docker

* turtlebot3 + GPU の環境構築  

* ビルド方法  
`docker build -t turtlebot3_ros_docker:melodic-devel`  

* 実行方法  
`sh run.sh`
* ROS:melodic-desktop-full
* OS: Ubuntu18.04
* ~/catkin_wsの中にturtlebot3,turtlebot3_simulations,turtlebot3_msgsが入ってます.
* ターミナルで以下のようなコマンドを実行する必要があります。[burger, waffle, waffle_pi]  
`export TURTLEBOT3_MODEL=burger`  

* vscodeのremote-containerを用いると便利です。  
https://code.visualstudio.com/docs/remote/containers
