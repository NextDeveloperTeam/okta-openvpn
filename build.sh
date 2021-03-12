set -e
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin $DOCKER_REPO_URL
export GIT_SHA1=`git rev-parse HEAD`
docker build -t $DOCKER_REPO_URL/okta-openvpn:$GIT_SHA1 .
docker push $DOCKER_REPO_URL/okta-openvpn:$GIT_SHA1
