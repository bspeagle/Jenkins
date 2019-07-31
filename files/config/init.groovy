#!groovy
 
import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule

Properties props = new Properties()
File propsFile = new File('/var/lib/jenkins/init.groovy.d/jenkins.env')
propsFile.withInputStream {
    props.load(it)
}

def instance = Jenkins.getInstance()
 
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(props.admin_username, props.admin_password)
instance.setSecurityRealm(hudsonRealm)
 
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()
 
Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)

instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)