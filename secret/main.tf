variable "db_password" {
  type      = string
  sensitive = true
}

# 実際はDBのパスワード欄などに渡す
resource "terraform_data" "db" {
  input = var.db_password
}
