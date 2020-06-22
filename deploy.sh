docker build -t iamstefin/muti-client:latest -t iamstefin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t iamstefin/multi-server:latest -t iamstefin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t iamstefin/multi-worker:latest -t iamstefin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push "iamstefin/multi-client:latest"
docker push "iamstefin/multi-server:latest"
docker push "iamstefin/multi-worker:latest"

docker push iamstefin/multi-client:$SHA
docker push iamstefin/multi-server:$SHA
docker push iamstefin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=iamstefin/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=iamstefin/multi-worker:$SHA
kubectl set image deployments/client-deployment client=iamstefin/multi-client:$SHA
