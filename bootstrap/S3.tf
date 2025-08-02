resource "aws_s3_bucket" "remote_s3" {
  bucket = "git-jenkins-terraform-intigration-state-bucket"

  tags = {
    Name = "git-jenkins-terraform-intigration-state-bucket"
  }
}