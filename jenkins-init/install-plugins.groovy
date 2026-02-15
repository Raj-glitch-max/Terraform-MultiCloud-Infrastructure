#!groovy
import jenkins.model.Jenkins

def plugins = [
    "git",
    "workflow-aggregator",
    "pipeline-stage-view",
    "terraform",
    "credentials",
    "credentials-binding",
    "github",
    "slack",
    "email-ext",
    "ansicolor"
]

def pm = Jenkins.instance.pluginManager
def uc = Jenkins.instance.updateCenter

plugins.each {
    if (!pm.getPlugin(it)) {
        println("Installing ${it}")
        def plugin = uc.getPlugin(it)
        plugin.deploy()
    }
}
