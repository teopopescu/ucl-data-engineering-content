data "aws_iam_group" "students" {
  group_name = "students"
}

resource "aws_iam_user" "studentTest" {
  count         = length(var.users_to_be_created)
  name          = var.users_to_be_created[count.index]
  force_destroy = true
  tags = {
    welcome_tag = "Welcome to the Data Engineering course."
  }
}

resource "aws_iam_group_membership" "students_group_membership" {
  name  = "students_group_membership"
  users = aws_iam_user.studentTest[*].name
  group = data.aws_iam_group.students.group_name
}

resource "aws_iam_access_key" "studentTestAccessKey" {
  count   = length(var.users_to_be_created)
  user    = aws_iam_user.studentTest[count.index].name
  pgp_key = "keybase:louisucl"
}

resource "aws_iam_user_login_profile" "studentTestLogin" {
  count                   = length(var.users_to_be_created)
  user                    = aws_iam_user.studentTest[count.index].name
  pgp_key                 = "keybase:louisucl"
  password_reset_required = true
}

output "users_details" {
  value = [
    aws_iam_user.studentTest[*].name,
    aws_iam_user_login_profile.studentTestLogin[*].encrypted_password,
    aws_iam_access_key.studentTestAccessKey[*].id,
    aws_iam_access_key.studentTestAccessKey[*].encrypted_secret,
  ]
}
