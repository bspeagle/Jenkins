node {
    parameters {
        string(name: 'S3_BUCKET', description: 'Which bucket should we store files in?')
    }
    stage("Credentials") {
        sh '''
        cd /var/lib/jenkins;
        [ -f /var/lib/jenkins/credentials.xml ] && tar czvf /tmp/credentials.tgz secret* credentials.xml || tar czvf /tmp/credentials.tgz secret*;
        aws s3 cp /tmp/credentials.tgz s3://''' + params.S3_BUCKET + ''';
        '''
    }
    stage("Jobs") {
        try {
            sh '''
            cd /var/lib/jenkins;
            tar czvf /tmp/jobs.tgz jobs*;
            '''
        }
        catch (Exception e) {
            echo 'Stage passed with an error but file still created so ignoring error :) - ' + e
            sh 'aws s3 cp /tmp/jobs.tgz s3://' + params.S3_BUCKET + ';'
        }
    }
    stage("Github Server Config") {
        sh '''
        cd /var/lib/jenkins;
        [ -f /var/lib/jenkins/github-plugin-configuration.xml ] && aws s3 cp github-plugin-configuration.xml s3://''' + params.S3_BUCKET + ''' || echo "File Not Found";
        '''
    }
    stage("Config") {
        sh '''
        cd /var/lib/jenkins;
        aws s3 cp config.xml s3://''' + params.S3_BUCKET + ''';
        '''
    }
    stage("Users") {
        sh '''
        cd /var/lib/jenkins;
        tar czvf /tmp/users.tgz users*;
        aws s3 cp /tmp/users.tgz s3://''' + params.S3_BUCKET + ''';
        '''
    }
    stage("Nodes") {
        sh '''
        cd /var/lib/jenkins;
        tar czvf /tmp/nodes.tgz nodes*;
        aws s3 cp /tmp/nodes.tgz s3://''' + params.S3_BUCKET + ''';
        '''
    }
    stage("Fingerprints") {
        sh '''
        cd /var/lib/jenkins;
        [ -f /var/lib/jenkins/fingerprints ] && tar czvf /tmp/fingerprints.tgz fingerprints* || echo "Directory Not Found";
        [ -f /tmp/fingerprints.tgz ] && aws s3 cp /tmp/fingerprints.tgz s3://''' + params.S3_BUCKET + ''' || echo "File Not Found";
        '''
    }
    stage("ManageFiles Plugin Config") {
        sh '''
        cd /var/lib/jenkins;
        [ -f /var/lib/jenkins/org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml ] && aws s3 cp org.jenkinsci.plugins.configfiles.GlobalConfigFiles.xml s3://''' + params.S3_BUCKET + ''' || echo "File Not Found";
        '''
    }
}