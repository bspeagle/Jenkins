#!/bin/bash

sudo yum update –y

sudo yum install -y java-1.8.0-openjdk.x86_64
sudo /usr/sbin/alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
sudo /usr/sbin/alternatives --set javac /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/javac

sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

sudo amazon-linux-extras install epel -y
sudo yum update -y
sudo yum install jenkins -y
sudo systemctl daemon-reload

echo 'jenkins  ALL=(ALL:ALL) ALL' >> /etc/sudoers

wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -O terraform.zip
unzip terraform.zip
sudo mv terraform /usr/bin/
rm terraform.zip

sudo yum install git -y

sudo yum install jq -y

curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum -y install nodejs

sudo npm install -g node-lambda

sudo yum install -y docker
sudo usermod -a -G docker jenkins
sudo service docker start

sudo amazon-linux-extras install -y php7.2
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

sudo amazon-linux-extras install -y php7.2
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# You may need to pass the aws --region flag also for all aws cp commands listed below depending on profile/permissions setup in AWS
# e.g., aws s3 cp s3://${s3_bucket}/${env_file} --region us-east-1 /var/lib/jenkins/init.groovy.d/ 
aws s3 cp s3://${s3_bucket}/${env_file} /var/lib/jenkins/init.groovy.d/
aws s3 cp s3://${s3_bucket}/${init_file} /var/lib/jenkins/init.groovy.d/
aws s3 cp s3://${s3_bucket}/${plugin_script} /var/lib/jenkins/setup/
aws s3 cp s3://${s3_bucket}/${plugin_file} /var/lib/jenkins/setup/

aws s3 cp s3://${s3_bucket}/${jobs_file} /tmp/
tar xzvf /tmp/jobs.tgz -C /var/lib/jenkins/
sudo chown jenkins /tmp/jobs.tgz

credResponse=$(aws s3 ls ${s3_bucket}/credentials.tgz)
if [[ $credResponse != "" ]]
then
    aws s3 cp s3://${s3_bucket}/credentials.tgz /tmp/
    tar xzvf /tmp/credentials.tgz -C /var/lib/jenkins/
    sudo chown jenkins /tmp/credentials.tgz
fi

conResponse=$(aws s3 ls ${s3_bucket}/config.xml)
if [[ $conResponse != "" ]]
then
    rm /var/lib/jenkins/config.xml
    aws s3 cp s3://${s3_bucket}/config.xml /var/lib/jenkins/
fi

gConResponse=$(aws s3 ls ${s3_bucket}/github-plugin-configuration.xml)
if [[ $gConResponse != "" ]]
then
    aws s3 cp s3://${s3_bucket}/github-plugin-configuration.xml /var/lib/jenkins/
fi

uResponse=$(aws s3 ls ${s3_bucket}/users.tgz)
if [[ $uResponse != "" ]]
then
    aws s3 cp s3://${s3_bucket}/users.tgz /tmp/
    tar xzvf /tmp/users.tgz -C /var/lib/jenkins/
    sudo chown jenkins /tmp/users.tgz
fi

nResponse=$(aws s3 ls ${s3_bucket}/nodes.tgz)
if [[ $nResponse != "" ]]
then
    aws s3 cp s3://${s3_bucket}/nodes.tgz /tmp/
    tar xzvf /tmp/nodes.tgz -C /var/lib/jenkins/
    sudo chown jenkins /tmp/nodes.tgz
fi

fResponse=$(aws s3 ls ${s3_bucket}/fingerprints.tgz)
if [[ $fResponse != "" ]]
then
    aws s3 cp s3://${s3_bucket}/fingerprints.tgz /tmp/
    tar xzvf /tmp/fingerprints.tgz -C /var/lib/jenkins/
    sudo chown jenkins /tmp/fingerprints.tgz
fi

mfResponse=$(aws s3 ls ${s3_bucket}/org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml)
if [[ $mfResponse != "" ]]
then
    aws s3 cp s3://${s3_bucket}/org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml /var/lib/jenkins/
fi

cd /var/lib/jenkins/setup
sh install-plugins.sh $(echo $(cat plugins.txt))

sudo service jenkins start