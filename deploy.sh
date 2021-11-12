docker build -t jbmcnamara/multi-client:latest -t jbmcnamara211/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jbmcnamara/multi-server:latest -t jbmcnamara211/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jbmcnamara/multi-worker:latest -t jbmcnamara211/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jbmcnamara211/multi-client:latest
docker push jbmcnamara211/multi-server:latest
docker push jbmcnamara211/multi-worker:latest

docker push jbmcnamara211/multi-client:$SHA
docker push jbmcnamara211/multi-server:$SHA
docker push jbmcnamara211/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jbmcnamara211/multi-server:$SHA
kubectl set image deployments/client-deployment client=jbmcnamara211/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jbmcnamara211/multi-worker:$SHA
