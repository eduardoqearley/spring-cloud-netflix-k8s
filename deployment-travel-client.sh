### set docker env
eval $(minikube docker-env)

### build the repository
mvn clean  install

### build the docker images on minikube
cd travel-agency-service
docker build -t eqe99/travel-agency-service .
docker push eqe99/travel-agency-service:latest
cd ../client-service
docker build -t eqe99/client-service .
docker push eqe99/client-service:latest
cd ..

### secret and mongodb
kubectl delete -f travel-agency-service/secret.yaml
kubectl delete -f travel-agency-service/mongo-deployment.yaml

kubectl create -f travel-agency-service/secret.yaml
kubectl create -f travel-agency-service/mongo-deployment.yaml

### travel-agency-service
kubectl delete -f travel-agency-service/travel-agency-deployment.yaml
kubectl create -f travel-agency-service/travel-agency-deployment.yaml


### client-service
kubectl delete configmap client-service
kubectl delete -f client-service/client-service-deployment.yaml

kubectl create -f client-service/client-config.yaml
kubectl create -f client-service/client-service-deployment.yaml

# Check that the pods are running
kubectl get pods
