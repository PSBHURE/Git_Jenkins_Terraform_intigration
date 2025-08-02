resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name = "git-jenkins-terraform-intigration-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "git-jenkins-terraform-intigration-table"
  }
}