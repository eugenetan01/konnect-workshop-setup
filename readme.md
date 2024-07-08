# Setup

__1. Create a konnect/terraform.tfvars and add the following variable__

```
# terraform.tfvars
konnect_personal_access_token = "kpat_7TMp5Hb0IyYUL8psYriBWzBEJqWwLBWkqZU343yWrejw3Spj1"
```

__2. Run the konnect main.tf script__

```
terraform init

terraform plan

terraform apply
```

__3. Go to Konnect control plane and see the newly created control plane and do the following__

  - Create a data plane node
  - Copy the crt contents and paste it into a file called certs/kong-cert.crt
  - Copy the key contents and paste it into a file called certs/kong-cert.key

__4. Ensure the aws key is stored in the ec2/keys folder__

  - run `chmod 400 <your-key.pem>` if not yet

__5. Create a ec2/terraform.tfvars file and add the following__

```
aws_region         = "ap-southeast-1"
instance_ami       = "ami-06d753822bd94c64e"
instance_type      = "t3.small"
key_name           = "<your-key>"
security_group_id  = "<aws-security-group-id>"
private_key_path   = "./keys/<your-key>"
compose_file_path  = "./docker/docker-compose.yaml"
cert_file_path     = "./docker/certs/kong-cert.crt"
key_file_path      = "./docker/certs/kong-cert.key"
prometheus_file_path  = "./docker/prometheus.yml"
```

__6. Run the `main.tf` file in the ec2 folder__

```
terraform init

terraform plan

terraform apply
```

__7. SSH into created ec2 instance called `konnect-hands-on` and run `docker-compose up -d`__

__8. Verify in Konnect control plane that the data plane was initiated and created.__

# To do:

- Fix the provisioner - docker-compose not found error when running the docker-compose via terraform
