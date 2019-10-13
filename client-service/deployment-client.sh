### set docker env
# eval $(minikube docker-env)

### build the repository
mvn clean install

docker build -t eqe99/client-service .
docker push eqe99/client-service:latest

kubectl delete pod -l app=client-service

curl http://138.197.231.252/


