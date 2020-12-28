output "git_clone_link" {
    value = "${ join("", github_repository.this.*.http_clone_url, data.github_repository.this.*.http_clone_url) }"
}