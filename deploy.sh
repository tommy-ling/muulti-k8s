docker build -t tommyling79/multi-client:latest -t tommyling79/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tommyling79/multi-server:latest -t tommyling79/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tommyling79/multi-worker:latest -t tommyling79/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tommyling79/multi-client:latest
docker push tommyling79/multi-server:latest
docker push tommyling79/multi-worker:latest

docker push tommyling79/multi-client:$SHA
docker push tommyling79/multi-server:$SHA
docker push tommyling79/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tommyling79/multi-server:$SHA
kubectl set image deployments/client-deployment client=tommyling79/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tommyling79/multi-worker:$SHA