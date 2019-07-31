docker build -t horimz/multi-client:latest -t horimz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t horimz/multi-server:latest -t horimz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t horimz/multi-worker:latest -t horimz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push horimz/multi-client:latest
docker push horimz/multi-server:latest
docker push horimz/multi-worker:latest

docker push horimz/multi-client:$SHA
docker push horimz/multi-server:$SHA
docker push horimz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=horimz/multi-server:$SHA
kubectl set image deployemnts/client-deployment client=horimz/multi-client:$SHA
kubectl set image deployemnts/worker-deployment worker=horimz/multi-worker:$SHA

