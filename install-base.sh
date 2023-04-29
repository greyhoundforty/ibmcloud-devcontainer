set -e
export SHELLOPTS

echo ">> Installing base dependencies..."
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  git \
  grep \
  jq \

# Terraform
echo ">> Installing TFSwitch"
curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

# Kubernetes
echo ">> Installing kubectl"
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl --retry 10 --retry-delay 5 -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
mv kubectl /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl

# Helm
echo ">> Installing helm 3"
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# OpenShift CLI
echo ">> Installing OpenShift"
curl -LO https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz
tar zxvf openshift-client-linux.tar.gz
mv oc /usr/local/bin/oc
rm -rf README.md kubectl openshift-client-linux.tar.gz

# MC for S3
echo ">> Installing minio"
wget -O /usr/local/bin/mc https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x /usr/local/bin/mc

# Enable GIT for all directories to avoid prompt like `fatal: unsafe repository ('/app' is owned by someone else)`
git config --global --add safe.directory '*'

# Clean up
rm -rf /var/cache/apk/*
