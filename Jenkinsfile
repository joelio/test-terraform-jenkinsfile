@Library(['terraform-pipeline@v5.12']) _

// N.B. This is temp as I didn't have credentials
withAWS(credentials:'tetst-creds') {

// Build paramaters setup
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

// Would you start the fans, please!
Jenkinsfile.init(this)

// Decorate your TerraformEnvironmentStages with the AnsiColor plugin
AnsiColorPlugin.init() 

// Somewhere for terraform state to live
S3BackendPlugin.init()

// Terraform Files Location etc.
TerraformFormatCommand.withRecursive().withDiff()
TerraformDirectoryPlugin.withDirectory("terraform").init()

// Starts the validation stuff
ValidateFormatPlugin.init()
def validate = new TerraformValidateStage()

// Defines the stage instances
def deployUat = new TerraformEnvironmentStage('uat')
def deployProd = new TerraformEnvironmentStage('prod')

// Builder pattern to validate, run stage, approve on prod
validate.then(deployStage)
        .then(deployProd)
        .build()

}
