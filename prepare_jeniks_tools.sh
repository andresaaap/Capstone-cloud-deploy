echo "***************install docker *****************"
sudo apt install docker.io

echo "***************install jenkins *****************"
sudo apt install default-jdk-headless

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo add-apt-repository universe

sudo apt-get update


sudo apt-get install jenkins -y

echo “initialAdminPassword； `sudo less /var/lib/jenkins/secrets/initialAdminPassword`”


echo "***************install aws cli***************"
sudo apt-get install awscli

echo "***************install eksctl***************"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

echo `eksctl version`
echo "***************install kubectl***************"
sudo snap install kubectl --classic
echo `kubectl version --client`


echo "***************install tidy***************"
wget https://github.com/htacg/tidy-html5/releases/download/5.4.0/tidy-5.4.0-64bit.deb
sudo dpkg -i tidy-5.4.0-64bit.deb
