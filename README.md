# Terraform Init

This project is more of a quick start for Terraform remote states. It doesn't provide any modules or actual infrastructure other than setting up a bucket and getting IAM going.

## Install Terraform First: 
>I like to run Terraform as `tf` for shorthand so we'll make a link to it (steps 4 and 5), these steps (4 and 5) aren't required. 

Download: https://www.terraform.io/downloads.html

This is written for Mac users but you can adjust accordingly. 

Assuming you've downloaded the terraform executable to `~/Downloads`:
1. `cd ~/Downloads/`
2. `chmod +x terraform`
3. `cp -p terraform /usr/local/bin/`
4. `cd /usr/local/bin/`
5. `ln -s terraform tf`

## Steps to get up and running: 

### 1. AWS Should have a Terraform IAM user setup for API access. 
Here is an example policy that allows Terraform to perform the actions it needs to.
Terraform cannot create this account since this is granting access itself. Once the account is created, gather your access key and secret key for the user. 

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "IAM:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "Route53:*",
            "Resource": "*"
        }
    ]
}
```

### 2. Create the bucket that will hold your states. 
1. Terraform works by parsing files in the current directory, so get into the "create_bucket" folder in this project: `cd create_bucket`
2. Run `terraform init` (or `tf init`) -- it should say "Terraform has been successfully initialized!"
3. Modify the values for the region and bucket name in `terraform.tfvars`
4. Run `terraform apply` (or `tf apply`) -- This will prompt for your access & secret keys. You can also choose a region or just accept default as you've set it. If the displayed plan looks good, type `yes` and let it create the bucket. 

**You've now got a Terrraform user and a bucket created to store your state files.**

### 3. Using your new Terraform ecosystem
The actual infrastructure components you create are up to you and this project won't help you there (the Terraform docs are great).

However, you should store your state files in S3 instead of locally, here's an example of how a Terraform project could utilize S3: 
```
terraform {
  backend "s3" {
    bucket = "mybucketname"
    key    = "path/to/some/dir/mystatefile.tfstate"
    encrypt = true
    region     = "us-east-1"
  }
}
```

Using this method, you'll be able to store your project states inside S3. 

---

See More: 
https://www.terraform.io/docs/backends/index.html


