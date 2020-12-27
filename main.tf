# Environment variables for the TFE provider:
# TFE_TOKEN
# TFE_HOSTNAME

resource tfe_workspace "this" {
  name              = var.tfe_workspace_name != "" ? var.tfe_workspace_name : var.repository_name
  organization      = var.tfe_org_name
  auto_apply        = var.tfe_auto_apply
  working_directory = var.tfe_working_directory

  vcs_repo {
    identifier     = var.create_repo == true ? github_repository.this[0].full_name : data.github_repository.this[0].full_name
    branch         = var.repository_branch
    oauth_token_id = var.oauth_token_id
  }
}

resource github_repository "this" {
  count       = var.create_repo == true ? 1 : 0
  name        = var.repository_name
  description = var.repository_description

  private = var.repository_private

  template {
    owner      = var.template_repository_owner
    repository = var.template_repository_name
  }
}

data github_repository "this" {
  count = var.create_repo == false ? 1 : 0
  name  = var.repository_name
}

resource tfe_variable "env" {
  for_each     = var.env_var
  key          = each.key
  value        = each.value["value"]
  sensitive    = each.value["sensitive"]
  category     = "env"
  workspace_id = tfe_workspace.this.id
}

resource tfe_variable "tf" {
  for_each     = var.tf_var
  key          = each.key
  value        = each.value["value"]
  sensitive    = each.value["sensitive"]
  category     = "terraform"
  workspace_id = tfe_workspace.this.id
}