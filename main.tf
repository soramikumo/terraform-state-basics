terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }
  }
}

resource "local_file" "hello" {
  filename = "${path.module}/out/hello.txt"
  content  = "hello terraform\n"
}
