resource "terraform_data" "slow" {
  provisioner "local-exec" {
    command = "sleep 15"
  }
}
