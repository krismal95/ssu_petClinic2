#! /bin/bash
echo "Install jenkins"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install jenkins

echo "config jenkins"
HOME_JENKINS=/var/lib/jenkins
PYTH_VBOX=`pwd`

sudo service jenkins stop

echo "!!!cope file port"
#copy file jenkins whith change port:8090 
sudo cp -rf $PYTH_VBOX/jenkins /etc/default
sudo chown -R jenkins:jenkins /etc/default/jenkins

echo "!!!cope config "
#copy config jenkins
sudo cp -rf $PYTH_VBOX/config/* $HOME_JENKINS
sudo chown -R jenkins:jenkins $HOME_JENKINS/*

echo "!!!cope jobs"
#copy jobs
sudo cp -rp $PYTH_VBOX/jobs/* $HOME_JENKINS/jobs
sudo chown -R jenkins:jenkins $HOME_JENKINS/jobs/*
sudo chown -R jenkins:jenkins $HOME_JENKINS/jobs


echo "!!!install plugin"
#install plugins
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/script-security.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/command-launcher.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/bouncycastle-api.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/structs.hpi

wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/workflow-step-api.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/workflow-scm-step.hpi


wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/credentials.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/apache-httpcomponents-client-4-api.hpi

wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/ssh-credentials.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/scm-api.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/workflow-api.hpi

wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/junit.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/windows-slaves.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/display-url-api.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/mailer.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/matrix-auth.hpi

wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/antisamy-markup-formatter.hpi

wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/matrix-project.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/jsch.hpi

wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/git-client.hpi
wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/git.hpi

wget -N -P $HOME_JENKINS/plugins http://updates.jenkins-ci.org/latest/JDK_Parameter_Plugin.hpi


echo "!!!access list"
#access right
sudo chown -R jenkins:jenkins $HOME_JENKINS/plugins/*

#port guest->host
sudo iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 8090 -j ACCEPT


echo "!!!jenkins start"
sudo service jenkins start





