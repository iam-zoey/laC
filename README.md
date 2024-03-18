## Infrastructure As Code with Terraform and Ansible 
<img src="https://github.com/iam-zoey/iam-zoey/assets/67743970/936d7353-86f3-479e-acfa-f0a5c50bc94" align="left">

### Terraform
Use the following command to deploy your infrastructure defined in Terraform configurations:
```bash
terraform apply 
```
Use the following command to clean up your environment:
```bash
terraform destroy
```


### Ansible

```bash
ansible-playbook -i <AWS_HOSTS_FILE> --private-key <KEY_NAME> <PLAYBOOK_NAME>
```
Replace .. 
- `<AWS_HOSTS_FILE>` with the path to your Ansible inventory file containing the list of hosts to configure
- `<KEY_NAME>` with ssh key for connecting to the hosts. 
- `<PLAYBOOK_NAME>` with name of palybook for the execution. 
---
# For the detailed guidelines.. 
1. [Getting started with Terraform and AWS](https://www.notion.so/iam-zoey/1-Getting-started-with-AWS-9b1c9851ecbc46aaa3ddd08eab406437?pvs=4)
2. [Step-by-Step Guide to Installing Ansible](https://www.notion.so/iam-zoey/1-Install-Ansible-4e7433d2140a4b4780613869f191b48b?pvs=4)
3. [Setting Up AWS Network Infrastructure with Terraform](https://www.notion.so/iam-zoey/2-Setting-up-Network-a3f8c60215bd4fb9b0bf9cb33283c71b?pvs=4)
4. [Deploying Instances with Terraform](https://www.notion.so/iam-zoey/3-Deploying-Instance-0c6184e4da87474d87c7d4689d750756?pvs=4)
5. [Automating Grafana Installation with Ansible on Terraform Deployed Instances ](https://www.notion.so/iam-zoey/2-Install-Grafana-w-playbook-1ed9d86589034595be0ed085749faca1?pvs=4)
6. [Setting Up Jenkins on a Single Instance](https://iam-zoey.notion.site/4-Install-Jenkins-w-Playbook-2ac90bc5932b45e487734df68994cc0e?pvs=4)

---
# Reflections
[Reflections: Why I started and learned from this project](https://www.notion.so/iam-zoey/Infrastructure-as-Code-0ab33a87434a49a9aa097f8bcce832e4?pvs=4)
<br></br>
*: In this post-project reflection, I delve into the motivations behind starting this project and share valuable insights gained from the experience.*

