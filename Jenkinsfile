@Library(['terraform-pipeline@v5.12']) _
withAWS(credentials:'tetst-creds') {

BuildWithParametersPlugin.withBooleanParameter([
       name: 'PIPELINE_PREFERENCE',
       description: 'Do you like pipelines?',
       defaultValue: true
     ])
BuildWithParametersPlugin.withStringParameter([
       name: 'PIPELINE_THOUGHTS',
       description: 'What do you think about pipelines?',
       defaultValue: 'They make deployments so easy'
     ])


Jenkinsfile.init(this)
AnsiColorPlugin.init() // Decorate your TerraformEnvironmentStages with the AnsiColor plugin

S3BackendPlugin.init()

TerraformFormatCommand.withRecursive().withDiff()
TerraformDirectoryPlugin.withDirectory("terraform").init()
ValidateFormatPlugin.init()

def validate = new TerraformValidateStage()
//def deployQa = new TerraformEnvironmentStage('qa')
//def deployUat = new TerraformEnvironmentStage('uat')
def deployProd = new TerraformEnvironmentStage('prod')

validate.then(deployProd)
        .build()

}
