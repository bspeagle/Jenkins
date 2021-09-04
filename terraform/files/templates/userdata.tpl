#cloud-config

# Upgrade the instance on first boot
repo_update: true
repo_upgrade: all

# Add extra repos
yum_repos:
  jenkins:
    baseurl: http://pkg.jenkins.io/redhat
    gpgcheck: false
    gpgkey: https://jenkins-ci.org/redhat/jenkins-ci.org.key
    enabled: true
    name: Jenkins
  terraform:
    baseurl: https://rpm.releases.hashicorp.com/$release/hashicorp.repo
    gpgcheck: false
    enabled: true
    name: Terraform

# Packages to install
packages:
  - git
  - jq
  - yum-utils
  - java
  - jenkins
  - terraform

# Add users to the system
users:
  - default

runcmd:
  - sudo systemctl start jenkins
  - sudo systemctl enable jenkins
  - systemctl is-enabled jenkins







# Home sweet home
  - home_directory=/home/${agent_username}

# Install Botocore
  - pip3 install botocore boto3 requests ec2-metadata

# Mount secondary EBS volume
  - mkdir -p ${ebs_directory}
  - mkfs -t ext4 ${ebs_device_name}
  - mount ${ebs_device_name} ${ebs_directory}
  - echo "[-- EBS Volume Mount --]"

# Mount EFS
  # EFS needs a minute to become available
  - echo "Sleeping 2m before EFS..." && sleep 2m
  - mkdir -p ${efs_directory}
  - mount -t efs ${file_system_id} ${efs_directory}/
  - echo "${file_system_id}:/ ${efs_directory} efs tls,_netdev", >>, /etc/fstab]
  - echo "[-- EFS Mount --]"

# Download hash script,get hash for agent install and download agent installer
  - aws s3 cp s3://${s3_bucket}/${s3_object_key} $home_directory/${s3_object_key}
  - iic_response=$(python3 $home_directory/${s3_object_key})
  - export IIC_USERNAME=$(jq -r '.iics_username' <<< "$iic_response")
  - export IIC_INSTALL_TOKEN=$(jq -r '.installToken' <<< "$iic_response")
  - export IIC_DOWNLOAD_URL=$(jq -r '.downloadUrl' <<< "$iic_response")
  - cd $home_directory && { curl -o agent64_install_ng_ext.bin $IIC_DOWNLOAD_URL; cd -; }

# Install Agent
  - agentcore_directory=$home_directory/infaagent/apps/agentcore
  - chown ${agent_username}:${agent_username} $home_directory/agent64_install_ng_ext.bin
  - chmod +x $home_directory/agent64_install_ng_ext.bin
  - runuser -l ${agent_username} -c './agent64_install_ng_ext.bin -i silent'
  - echo "Installed Path - $(find / -name "infaagent")"
  - echo "[-- Agent Install --]"
  - (cd $agentcore_directory && sudo -u ${agent_username} ./infaagent startup)
  - echo "Sleeping 20 secs so agent can start..." && sleep 20
  - echo $IIC_INSTALL_TOKEN
  - (cd $agentcore_directory && sudo -u ${agent_username} ./consoleAgentManager.sh configureToken $IIC_USERNAME $IIC_INSTALL_TOKEN)
  - (cd $agentcore_directory && sudo -u ${agent_username} ./consoleAgentManager.sh getstatus)
  - echo "[-- Agent Startup and Registration --]"
