resource "aws_iam_role" "aft_states" {
  name = "aft-states"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "states.amazonaws.com" }
    }]
  })
  tags = local.mandatory_tags
}

resource "aws_sfn_state_machine" "p47_no_logging" {
  name     = "aft-account-provisioning-customizations"
  role_arn = aws_iam_role.aft_states.arn
  definition = jsonencode({
    StartAt = "Pass"
    States  = { Pass = { Type = "Pass", End = true } }
  })
  tags = local.mandatory_tags
}
