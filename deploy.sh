# logfile for debugging purposes
timestamp=$(date +%s)
LOG_FILE=deploy-${timestamp}.log
exec 3>&1 1>>${LOG_FILE} 2>&1 #send all output to the log file

echo "Deploying the Docker Swarm...." | tee /dev/fd/3

docker stack deploy -c laya-stack.yaml LAYA 

echo "Done!" | tee /dev/fd/3