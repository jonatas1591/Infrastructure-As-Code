# **Overview**

This code create a small and complete infrastructure in AWS to a web server. It create:
* VPC
* Security Groups
* Instances (You choose the number of instances)

After creates all infrastructure, it do a upload of a files in webserver to view a some information about the instances created. This files are in [](files/webapplication)

The main files are:
- main.tf
    * Configure the provider and region of infrastructure

 - variables.tf
    * Variables used to facility the view and modification. Here choose region of AWS, number of instances to create, base name to services, AZ's and IP's to public/private subnets.

    - vpc.tf
        * Virtual Private Cloud. Create and configure the network to be used by the services.

    - sec_group.tf
        * Infrastructure security groups . Allow rules to access the instances and others services
    - outputs.tf
        * Show information from services such as instance_dns