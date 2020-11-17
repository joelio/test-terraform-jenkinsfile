@Library(['terraform-pipeline@v5.12']) _
withAWS(credentials:'tetst-creds') {

environment {
   S3_BACKEND_BUCKET = "remote-state-storage-test-lon-aws"
   S3_BACKEND_REGION = "eu-west-2"
}


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
