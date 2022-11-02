# 19c

1- docker build :

./buildDockerImage.sh -v 19.3.0 -e

2- run helm :

helm install oracle-standalone19c --name central-oracle-db19c --namespace infra-services --tiller-namespace infra-services