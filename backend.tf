terraform {
  backend "remote" {
    organization = "test-zoey"

    workspaces {
      name = "terraform"
    }
  }
}
