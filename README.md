# **Overview**

Project to IAC. The idea is construct a complete IAC with CI/DI. But, now, I started by [AWS](Terraform/AWS). :D


Gradually, other providers will be added until the complete creation of a CI/DI.
<br/>

# **AWS**

This code create a small and complete infrastructure in AWS to a web server. It create:
1. VPC and public/private subnets
2. Security Groups
3. Instances (You choose the number of instances)
4. Load Balance



After creates all infrastructure, it do a upload of a files in webserver to view a some information about the instances created. This files are [here](Terraform/AWS/files/web_application).

The main files are:
- [main.tf](Terraform/AWS/main.tf)
    * Configure the provider and region of infrastructure

- [variables.tf](Terraform/AWS/variables.tf)
    <p>Variables used to facility the view and modification. Here choose region of AWS, number of instances to create, base name to services, AZ's and IP's to public/private subnets.</p>

- [vpc.tf](Terraform/AWS/vpc.tf)
    <p>Virtual Private Cloud. Create and configure the network, internet gateway, private/public subnet and route table to be used by the services.</p>

- [sec_group.tf](Terraform/AWS/sec_group.tf)
    <p>Infrastructure security groups . Allow rules to access the instances and others services.</p>

- [load_balance.tf](Terraform/AWS/load_balance.tf)
    <p>Create a load balance and attach instances it.</p>

- [outputs.tf](Terraform/AWS/outputs.tf)
    <p>Show information from services such as instance_dns.</p>