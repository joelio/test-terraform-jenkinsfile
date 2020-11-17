@Library(['terraform-pipeline@v5.12']) _

// N.B. This is temp as I didn't have credentials
// All the aws integration work is done inside this scope
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

  // After creating a PullRequest, the plan results for each 
  // environment are posted as a comment to the PullRequest.
  // A GITHUB_TOKEN environment variable should contain your Github PAT
  GithubPRPlanPlugin.init()
  
  // Decorate your TerraformEnvironmentStages with the AnsiColor plugin
  AnsiColorPlugin.init() 
  
  // Somewhere for terraform state to live
  S3BackendPlugin.init()
  
  // Terraform Files Location etc.
  TerraformDirectoryPlugin.withDirectory("terraform").init()
  
  // Starts the format and validation stuff
  TerraformFormatCommand.withRecursive().withDiff()
  ValidateFormatPlugin.init()
  def validate = new TerraformValidateStage()
  
  // Defines the stage and prod instances
  def deployStage = new TerraformEnvironmentStage('stage')
  def deployProd = new TerraformEnvironmentStage('prod')
  
  // Builder pattern to validate, run stage, approve on prod
  validate.then(deployStage)
          .then(deployProd)
          .build()
  
}
