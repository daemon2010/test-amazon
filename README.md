# Simple AWS VPC Terraform Configuration

This Terraform configuration creates a simple VPC infrastructure in a single AWS Availability Zone. It's designed to work with AWS assumed roles rather than static credentials.

## Architecture

The configuration creates the following resources:

- **VPC** with configurable CIDR block
- **Public Subnet** in one availability zone
- **Private Subnet** in the same availability zone
- **Internet Gateway** for public internet access
- **NAT Gateway** for private subnet outbound connectivity
- **Route Tables** with appropriate routing rules
- **Elastic IP** for the NAT Gateway

## Prerequisites

1. **AWS CLI** configured with appropriate permissions
2. **Terraform** >= 1.0 installed
3. **AWS IAM Role** with necessary permissions for VPC management

### Required AWS Permissions

Your assumed role should have permissions for:
- VPC management (create, modify, delete VPCs, subnets, route tables)
- Internet Gateway management
- NAT Gateway management
- Elastic IP management

## Authentication

This configuration uses AWS assumed roles. Ensure your AWS CLI is configured to assume the appropriate role:

```bash
# Configure AWS CLI with your assumed role
aws configure set role_arn arn:aws:iam::ACCOUNT-ID:role/ROLE-NAME
aws configure set source_profile default
aws configure set region us-west-2
```

Or use environment variables:
```bash
export AWS_ROLE_ARN="arn:aws:iam::ACCOUNT-ID:role/ROLE-NAME"
export AWS_ROLE_SESSION_NAME="terraform-session"
```

## Usage

1. **Clone and navigate to the repository:**
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Create your variables file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your desired values
   ```

3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Plan the deployment:**
   ```bash
   terraform plan
   ```

5. **Apply the configuration:**
   ```bash
   terraform apply
   ```

6. **Clean up (when needed):**
   ```bash
   terraform destroy
   ```

## Configuration Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region for deployment | `us-west-2` | No |
| `project_name` | Project name for resource naming | `simple-vpc` | No |
| `environment` | Environment name (dev, staging, prod) | `dev` | No |
| `vpc_cidr` | CIDR block for the VPC | `10.0.0.0/16` | No |
| `public_subnet_cidr` | CIDR block for public subnet | `10.0.1.0/24` | No |
| `private_subnet_cidr` | CIDR block for private subnet | `10.0.2.0/24` | No |

## Outputs

After successful deployment, the following outputs will be available:

- `vpc_id` - VPC identifier
- `public_subnet_id` - Public subnet identifier
- `private_subnet_id` - Private subnet identifier
- `internet_gateway_id` - Internet Gateway identifier
- `nat_gateway_id` - NAT Gateway identifier
- `nat_gateway_public_ip` - NAT Gateway public IP address

## Example terraform.tfvars

```hcl
aws_region = "us-east-1"
project_name = "my-app"
environment = "production"
vpc_cidr = "172.16.0.0/16"
public_subnet_cidr = "172.16.1.0/24"
private_subnet_cidr = "172.16.2.0/24"
```

## Cost Considerations

This configuration creates the following billable resources:
- NAT Gateway (~$45/month)
- Elastic IP (~$3.65/month when not attached to running instance)

To minimize costs in development environments, consider:
- Using a single public subnet without NAT Gateway
- Destroying resources when not in use

## Security Notes

- The configuration follows AWS best practices with separate public and private subnets
- Private subnet resources can only access the internet through the NAT Gateway
- No security groups are created - add them based on your specific requirements
- Consider enabling VPC Flow Logs for network monitoring

## Troubleshooting

### Common Issues

1. **Authentication errors**: Ensure your AWS CLI is properly configured with assumed role
2. **Permission denied**: Verify your IAM role has necessary VPC permissions
3. **CIDR conflicts**: Ensure subnet CIDRs are within the VPC CIDR range

### Useful Commands

```bash
# Check current AWS identity
aws sts get-caller-identity

# Validate Terraform configuration
terraform validate

# Format Terraform files
terraform fmt

# Show current state
terraform show
```
