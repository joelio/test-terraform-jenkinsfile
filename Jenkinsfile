@Library(['terraform-pipeline@v5.12']) _

Jenkinsfile.init(this)
AnsiColorPlugin.init() // Decorate your TerraformEnvironmentStages with the AnsiColor plugin

ValidateFormatPlugin.init()
TerraformFormatCommand.withRecursive().withDiff()
TerraformDirectoryPlugin.withDirectory("terraform").init()

def validate = new TerraformValidateStage()
def deployQa = new TerraformEnvironmentStage('qa')
def deployUat = new TerraformEnvironmentStage('uat')
def deployProd = new TerraformEnvironmentStage('prod')

validate.then(deployQa)
        .then(deployUat)
        .then(deployProd)
        .build()
