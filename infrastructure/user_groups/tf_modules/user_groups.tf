resource "aws_iam_group" "students" {
  name = "students"
}

resource "aws_iam_group_policy" "students_policy" {
  name  = "students_policy"
  group = aws_iam_group.students.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "iam:ChangePassword",
            "Resource": "arn:aws:iam::008436270209:user/*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "lambda:CreateFunction",
                "s3:GetObjectVersionTagging",
                "lambda:GetFunctionConfiguration",
                "s3:GetStorageLensConfigurationTagging",
                "s3:GetObjectAcl",
                "s3:GetBucketObjectLockConfiguration",
                "lambda:ListProvisionedConcurrencyConfigs",
                "lambda:GetProvisionedConcurrencyConfig",
                "s3:GetObjectVersionAcl",
                "lambda:ListLayerVersions",
                "lambda:ListLayers",
                "lambda:DeleteFunction",
                "lambda:ListCodeSigningConfigs",
                "lambda:GetAlias",
                "s3:DeleteObject",
                "s3:GetBucketPolicyStatus",
                "s3:GetObjectRetention",
                "lambda:ListFunctions",
                "s3:GetBucketWebsite",
                "lambda:GetEventSourceMapping",
                "lambda:InvokeFunction",
                "s3:GetJobTagging",
                "lambda:ListAliases",
                "s3:ListJobs",
                "s3:GetObjectLegalHold",
                "s3:GetBucketNotification",
                "lambda:GetFunctionCodeSigningConfig",
                "s3:GetReplicationConfiguration",
                "s3:ListMultipartUploadParts",
                "lambda:UpdateFunctionCode",
                "s3:PutObject",
                "s3:GetObject",
                "lambda:ListFunctionEventInvokeConfigs",
                "lambda:ListFunctionsByCodeSigningConfig",
                "lambda:GetFunctionConcurrency",
                "s3:DescribeJob",
                "lambda:ListEventSourceMappings",
                "s3:GetAnalyticsConfiguration",
                "s3:GetObjectVersionForReplication",
                "s3:GetStorageLensDashboard",
                "s3:GetLifecycleConfiguration",
                "s3:GetAccessPoint",
                "s3:GetInventoryConfiguration",
                "s3:GetBucketTagging",
                "lambda:ListVersionsByFunction",
                "lambda:GetLayerVersion",
                "s3:DeleteObjectVersion",
                "s3:GetBucketLogging",
                "s3:ListBucketVersions",
                "lambda:GetAccountSettings",
                "s3:ListBucket",
                "s3:GetAccelerateConfiguration",
                "lambda:GetLayerVersionPolicy",
                "s3:GetBucketPolicy",
                "s3:GetEncryptionConfiguration",
                "s3:GetObjectVersionTorrent",
                "lambda:ListTags",
                "s3:GetBucketRequestPayment",
                "s3:GetAccessPointPolicyStatus",
                "s3:GetObjectTagging",
                "s3:GetMetricsConfiguration",
                "s3:GetBucketOwnershipControls",
                "s3:GetBucketPublicAccessBlock",
                "s3:ListBucketMultipartUploads",
                "s3:ListAccessPoints",
                "lambda:GetFunction",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:ListStorageLensConfigurations",
                "s3:GetObjectTorrent",
                "s3:GetStorageLensConfiguration",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "lambda:GetFunctionEventInvokeConfig",
                "s3:GetBucketCORS",
                "lambda:GetCodeSigningConfig",
                "s3:GetBucketLocation",
                "s3:GetAccessPointPolicy",
                "lambda:GetPolicy",
                "s3:GetObjectVersion"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}