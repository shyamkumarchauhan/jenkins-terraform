# Objective of PoC

Create a VPC, use CIDR of your own choice in us-east-2 . Also have the internet gateway and required routes defined
Create an AutoScalingGroup
Create a WebServer Instance
Change the default TCP port of WebServer from port 80 to 8080
Create a load balancer and point to the webserver
Open a TCP Port 80 on security group to allow incoming traffic from the world
Create the IAM Users and grant them access to only restart web Server


# Expectations

Use terraform to achieve this
Above task must be reusable upon changing the variables
A Jenkins job calling will be preferred

# Steps to Implemenet the Complete PoC

# Step :1) Download the required tools

Download putty and winscp on Desktop

# Step :2 ) Create a VM in us-east-1

Spin up a ubuntu VM in us-east-1 region and in security group allow access to port 8080 TCP from 0.0.0.0/0

# Step :2 ) Install Jenkins on this VM

sudo apt update
sudo apt install openjdk-8-jdk

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update
sudo apt install jenkins
systemctl status jenkins

sudo ufw allow 8080
sudo ufw status

http://your_ip_or_domain:8080
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Step :3) Install git on this VM

apt-get update
apt-get install git-core
git --version
git config --global user.name "usernames"
git config --global user.email "username@gmail.com"
cat ~/.gitconfig
git config --list

# Step :4) Install terraform on this VM

Install terraform
wget https://releases.hashicorp.com/terraform/0.11.11//terraform_0.11.11_linux_amd64.zip
unzip terraform_0.11.10_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version

# Step :5) Create Private SSH key name "terraform.pem" in us-east-2 region and save that key to /home/ubuntu of the VM


# Step :6) hookup with git repository with the jenkins

go to github.com and create a new repository (username/terraform-web )....> click settings ----> webhook ---under payload URL (http://18.212.55.133:8080/github-webhook/)
Content TYPE -----> (application/json) -----> Let me select individual --- ( pull requests and pushes) ---> select Active


# Step : 7)  Create a freestyle project name "poc-trigger" and a pipeline project name "Poc-Piepleine" on Jenkinsfile

 General --> Github Project --/> Project url
 Source Code Management ---> Git --> Repository url
 Build Triggers ---> Github hook trigger for GITScm polling
 Build --> Poc-Pipeline

 Create a Pipeline project "Poc-Pipeline"

 General --> GitHub Project --> Project URL
 Build Triggers --> Build Periodically
 Pipeline --> SCN --> Git --> Repository URL --> Script Path --> Jenkinsfile

# Step :7) Go to your working directory on ubuntu VM and commit the files .

git remote add origin https://github.com/username/terraform-web.git
git status
git add <files.tf>
git commit -m "updated Jenkinsfile"
git push origin -u master

# Step :8 ) you will ge the loadbabalancer URL and browse the URL to access your application
