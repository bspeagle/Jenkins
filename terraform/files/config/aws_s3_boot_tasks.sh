#!/bin/sh
# AWS S3 boot tasks

## Copy config files to S3
aws s3 cp s3://${s3_bucket}/${env_file} /var/lib/jenkins/init.groovy.d/
aws s3 cp s3://${s3_bucket}/${init_file} /var/lib/jenkins/init.groovy.d/
aws s3 cp s3://${s3_bucket}/${plugin_script} /var/lib/jenkins/setup/
aws s3 cp s3://${s3_bucket}/${plugin_file} /var/lib/jenkins/setup/

## Download files from S3 to Jenkins directory
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