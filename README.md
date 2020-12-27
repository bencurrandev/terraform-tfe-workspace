This module can be used for the onboarding of new workspaces in Terraform Cloud.

It will create a repository in Github, create a Workspace in Terraform Cloud, and connect it to the newly created repository.

Sample usage:

```
module "my-repo" {
  oauth_token_id         = var.oauth_token_id 
  source                 = "tfe.humblelab.com/demos/management/workspace"
  version                = "0.0.20"
  repository_owner       = "Ben Curran"
  repository_name        = "grim repo"
  repository_slug        = "grim-repo"
  repository_project_key = "demo"
  tfe_workspace_name     = "grim-repo"
  tfe_org_name           = "demo"
  tfe_auto_apply         = "True"
  tfe_working_directory  = "tf"
}
```

Please use the exact text for the first two lines, and check for the most recent module version. All other variables should be entered according to your requirements.


