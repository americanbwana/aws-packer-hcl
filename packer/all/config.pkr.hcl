packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.9"
      source = "github.com/hashicorp/amazon"
    }
    windows-update = {
    version = "0.14.0"
    source = "github.com/rgl/windows-update"
    }
  }
}