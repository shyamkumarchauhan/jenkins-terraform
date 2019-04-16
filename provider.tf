# Define AWS as our provider
provider "aws" {
  access_key = "AKIXXXXXXXXXXXXXX"
  secret_key = "1WmoQRA9XXXXXXXXXXXXXXXX"
  region = "${var.region}"
}
