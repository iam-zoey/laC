pipeline {
    agent any
    environment {
        TF_IN_AUTOMATION = 'true'
        AWS_SHARED_CREDENTIALS_FILE='~/.aws/cre*'
    }
   
    stages {
        
        stage('Init') {
            steps {
                sh 'ls'
                sh 'terraform init -no-color'
            }
        }
        //  stage("set env var"){
        //     steps{
        //         sh 'export AWS_PROFILE = user1'
        //     }
        // }
        stage('Plan') {
            steps {
                withAWS(credentials:"AWS_KEY" , region: 'ap-northeast-2') {
                    sh 'terraform plan -no-color -var-file="$BRANCH_NAME.tfvars"'     
                }
            }
        }
        stage('Validate Apply') {
            when {
                beforeInput true
                branch "dev"
            }
            input {
                message "Do you want to Apply this plan?"
                ok "Apply"
            }
            steps {
                echo 'Apply Accepted'
            }
        }
        stage('Apply') {
            steps {
                withAWS(credentials:"AWS_KEY" , region: 'ap-northeast-2') {
                    sh 'terraform apply -auto-approve -no-color -var-file="$BRANCH_NAME.tfvars"'
                }
            }
        }
        stage('Inventory') {
          steps {
                sh 'printf "\\n $(terraform output -json instance_ips | jq -r \'.[]\')" >> aws_hosts'
            }
        }
        stage('EC2 Wait') {
            steps {
                withAWS(credentials:"AWS_KEY" , region: 'ap-northeast-2') {
                    sh '''aws ec2 wait instance-status-ok \\
                    --instance-ids $(terraform output -json instance_ids | jq -r \'.[]\') \\
                    --region ap-northeast-2'''
                }
            }
        }
        stage('Validate Ansible') {
            when {
                beforeInput true
                branch "dev"
            }
            input {
                message "Do you want to run Ansible?"
                ok "Run Ansible"
            }
            steps {
                echo 'Ansible Approved'
            }
        }
        stage('Ansible') {
            steps {
                ansiblePlaybook(credentialsId: 'ec2-key', inventory: 'aws_hosts', playbook: 'playbooks/main-playbook.yml')
            }
        }
        stage ('Test nodes'){
            steps{
                ansiblePlaybook(credentialsId: 'ec2-key', inventory: 'aws_hosts', playbook: 'playbooks/node-test.yml')
            }
        }
        stage('Validate Destroy') {
            input {
                message "Do you want to destroy?"
                ok "Destroy"
            }
            steps {
                echo 'Destroy Approved'
            }
        }
        stage('Destroy') {
            steps {
                 withAWS(credentials:"AWS_KEY" , region: 'ap-northeast-2') {
                     sh 'terraform destroy -auto-approve -no-color -var-file="$BRANCH_NAME.tfvars"'
                }
            }
        }
    }
    post {
        success {
            echo 'Success!'
        }
        failure {
            sh 'terraform destroy -auto-approve -no-color -var-file="$BRANCH_NAME.tfvars"'
        }
        aborted {
            sh 'terraform destroy -auto-approve -no-color -var-file="$BRANCH_NAME.tfvars"'
        }
    }
}





