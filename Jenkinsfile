@Library(['terraform-pipeline@v5.12']) _

Jenkinsfile.init(this)
CredentialsPlugin.withBuildCredentials('tetst-creds').init()
AnsiColorPlugin.init() // Decorate your TerraformEnvironmentStages with the AnsiColor plugin

TerraformFormatCommand.withRecursive().withDiff()
TerraformDirectoryPlugin.withDirectory("terraform").init()
ValidateFormatPlugin.init()

def validate = new TerraformValidateStage()
def deployQa = new TerraformEnvironmentStage('qa')
def deployUat = new TerraformEnvironmentStage('uat')
def deployProd = new TerraformEnvironmentStage('prod')

validate.then(deployQa)
        .then(deployUat)
        .then(deployProd)
        .build()
