terraform {
  cloud {
    organization = "vashisthavinod_org"

    workspaces {
      name = "learn-terraform-github-actions"
    }
  }
  required_providers {
          aws = {
          source = "hashicorp/aws"
          version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
 region = "ap-south-1"
}

# Create instances from list  dynamically of same type or same AMIs using locals and for_each loop in resources
/*
locals {
        instances = toset (
            ["TF1instance","TF2instance","TF3instance"]
       )
}
*/

# Create differnet instances from map dynamically using different AMIs using locals and for_each loop in resources

locals {
        instances = {"Ubuntu":"ami-0f5ee92e2d63afc18","amazonlinux":"ami-0700df939e7249d03","radhat":"ami-008b85aa3ff5c1b02"} 
}

resource "aws_instance" "terraform_test_instance" {
         #count = 3
          for_each = local.instances
         #for same type AMIs use this code else use each.key for AMI
         # ami = "ami-0f5ee92e2d63afc18"
          ami = each.value 
          instance_type = "t2.micro"
          tags = {
              #for same type AMIs use this code else use each.name for AMI
              # Name =  each.key
              Name = each.key
              #Name = "terraform_batch1-${count.index}"
             }
}

#if we are using count then we can use this output value to check the public IP...

/*
output "ec2_public_ips" {
    value = aws_instance.terraform_test_instance[*].public_ip
}
*/
