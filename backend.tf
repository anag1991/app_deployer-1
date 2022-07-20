terraform {
  backend "gcs" {
    bucket = "backend-xltmkfaeyrcibbij"
    prefix = "/dev/home/jc_evolve_project/app_deployer"
  }
}
