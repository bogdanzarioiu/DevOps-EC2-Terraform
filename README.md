# Provisioning an AWS EC2 instance with Terraform
This is a small project in which I pvovisioned an EC2 instance on AWS using Terraform. The EC2 instance will act as a web server.<br/>
# 1. Downloading Terraform
Terraform can be downloaded from here: https://www.terraform.io/downloads.html <br/>
It is useful to add the binary to your PATH so it can be executed from any location. Running `terraform -v` should print `Terraform v0.13.1` since at the moment this is the latest version.<br/>
# 2. Terraform init
Terraform allows you to declare how you would like your infrastructure to look like using HCL(Hashicorp Configuration Language).Is a Infrastructure as Code tool. You don't provide exact steps on how that infrastructure should be created.<br/>
An important concept in Terraform is **`the state`**. This is a file updated by Terraform every time you add, create or modify your infrastructure. It contains the current state of your infrastructure.<br/>
Let's say that you deployed a EC2 instance with Terraform. If you will try to run the same deployment without any changes, Terraform won't do any changes, won't provision another EC2 instance simply because the configuration you defined in your `file.tf` file matches the current state.<br/>
Another important notion is the concept of **`providers`**. A provider is simply a cloud platform like AWS, Azure, GCP or even another service like Kubernetes.
Each provider has a plugin that once installed, allows Terraform to connect to it and access the available resources for deployment.<br/>
For the AWS provider, Terraform needs **`aws_access_key_id`** and **`aws_secret_access_key`** to connect to the AWS API. You can specify these in plain text as you can see below(but not recommended since your deployment files will reside on Github and anyone would have access to your credentials).<br/>

```terraform
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
```

In my example I used a shared credentials file located in **`~/.aws/credentials`**. But you need to have AWS CLI previously installed in order for this to work.<br/>
![image](https://user-images.githubusercontent.com/24807183/92100106-aaf49d80-eddb-11ea-88ae-664db53873c4.png)


# 3. Terraform plan
 `terraform plan` does a dry-run of your code, it doesn't actually provision anything, but it shows you what would be provisioned if you apply your config file.
 It's an optional step, but useful.<br/>
 ![image](https://user-images.githubusercontent.com/24807183/92100248-d6778800-eddb-11ea-88d7-483473d8b7b2.png)

 # 4. Terraform apply
 This is the command that does the provisioning acording to your file. When running `terraform apply`, Terraform will talk with AWS API in order to deploy your infrastructure. You see the status of the deployment and you receive a confirmation message in case all was ok.<br/>
 ![image](https://user-images.githubusercontent.com/24807183/92100381-09ba1700-eddc-11ea-887a-6ab164740b93.png)

 # 5. Cool part!
 One thing that blew my mind when I started to work with AWS was the fact that when you provison a EC2 instance you have an option called `"user data"` in the management console. There you could paste a bash script that will run after your instance is provisioned.<br/>
 This works in Terraform too! I used it actually in order to install and start  apache2 on the EC2 instance. I even added a short confirmation message to `index.html` page hosted by our web server. <br/>
 <br/>
 ***Two things I forgot to mention:.***<br/> 
 ***Prior to all the deployment I created a key-pair in AWS and referenced its name in the terraform file. This key is used to connect to our instance using SSH.<br/>
 After deployment I modified the inbound rules for the default security group attached to my instance in order to allow HTTP and SSH traffic(ports 80 and 22).You could do this in Terraform too, just creating a security group resource and attaching it to our instance.***<br/>
 # 6. Terraform destroy
 Running `terraform destroy` will destroy your current infrastructure. Let's say you provisioned many resources and you need to delete one of them. You could simply comment the code for that resource and run again `terraform apply` . `However, you need to be careful if you have resources depending on each other.`<br/>
 It was a fun little project that taught me the basics of working with Terraform and I really feel I learned something new and useful.
 
 
 
 
 









