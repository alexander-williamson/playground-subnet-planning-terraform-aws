# Playground - Subnet Planning in Terraform

This is an example project in Terraform that uses the built in function `cidrsubnet` to calculate offsets.

Given a base address for an AWS VPC of /16, and enough spaces to include:
- one subnet per availability zone (us-east-1 has 10)
- support for local-zones
- additional space for VPN subnets
- a few extra subnets for growth (depending on your planning requirements)

The list of AZs and local zones are listed in the [AWS Global Infrastructure](https://aws.amazon.com/about-aws/global-infrastructure) documentation.

Since we need an AZ per subnet (10) plus local zones (14) which is 24 for both private and public subnets takes us to 48 already, plus leaving some additional room. 

For 48+ subnets we'll need to divide /16 into something with enough space, so we can use /22 which when using the largest space has 64 spaces.

```terraform
cidrsubnet("10.1.0.0/24", 6, 0) # 10.1.0.0/24
cidrsubnet("10.1.0.0/24", 6, 0) # 10.1.4.0/24
cidrsubnet("10.1.0.0/24", 6, 0) # 10.1.8.0/24
...
cidrsubnet("10.1.0.0/24", 6, 32) # 10.1.128.0/24
cidrsubnet("10.1.0.0/24", 6, 33) # 10.1.132.0/24
cidrsubnet("10.1.0.0/24", 6, 34) # 10.1.136.0/24
```

A great tool to verify this is [Visual Subnet Calculator](https://visualsubnetcalc.com) where you can interactively work out your subnets using the buttons on the right to divide or join the subnets.

![Visual Subnet Calculator][logo]

> _Notable mention to what I can only assume is the original version of the [Visual Subnet Calculator](https://www.davidc.net/sites/default/subnets/subnets.html) however this one does not allow joining_

## Running this project

This only uses output variables, and does not create anything so `-auto-approve` can be used safely.

```
terraform init
terraform apply -auto-approve
```

[logo]: docs/visual-subnet-calculator-screenshot-oct-3-2024.png "Visual Subnet Calculator"