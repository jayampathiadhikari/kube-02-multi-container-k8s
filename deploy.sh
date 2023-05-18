docker build -t jayampthi/multi-react-client:latest -t jayampthi/multi-react-client:$SHA -f ./client/Dockerfile ./client
docker build -t jayampthi/multi-server:latest -t jayampthi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jayampthi/multi-worker:latest -t jayampthi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jayampthi/multi-react-client:latest
docker push jayampthi/multi-server:latest
docker push jayampthi/multi-worker:latest

docker push jayampthi/multi-react-client:$SHA
docker push jayampthi/multi-server:$SHA
docker push jayampthi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jayampthi/multi-react-client:$SHA
kubectl set image deployments/server-deployment server=jayampthi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jayampthi/multi-worker:$SHA
