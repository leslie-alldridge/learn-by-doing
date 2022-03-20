terraform {
  backend "s3" {
    bucket = "tf-state-production"
    key    = "renaming-module"
    region = "ap-southeast-2"
  }
}

// When you're ready to use the module you can uncomment the below:

module "iam" {
  source = "./module-iam"
}
