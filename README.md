# 🐙VPC - ELB - EC2
3개의 private subnet에 존재하는 EC2 instance를 웹 접근 시 Application Load Balancer를 통하여 접근하며 ssh 접근은 bastion host를 통하여 접근
<br>현재의 예제는 bastion host 구현은 제외되었다.

# 🐙Architecture
![image](https://github.com/peachApeach/VPC-ELB-EC2/assets/106210881/245cc708-6645-4991-969f-8f4128c0bb4e)

# 🐙Tools
### ✔️ Tech Stacks
![AWS](https://img.shields.io/badge/AWS-232F3E.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
### ✔️ IaC
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
# 🐙Environment Variables
- keyName : ec2 연결 시 사용되는 .pem 키 이름
