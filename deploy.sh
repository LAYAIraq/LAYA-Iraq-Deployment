# access keys for git repos
ACC_FE="97u6MAcyJUcYNE_uMYo6"
ACC_BE="xS4dyDbYmh-9QcrLkpLg"

# logfile for debugging purposes
timestamp=$(date +%s)
LOG_FILE=deploy-${timestamp}.log
exec 3>&1 1>>${LOG_FILE} 2>&1 #send all output to the log file

echo "Building LAYA Vechta Project for Deployment...\n" | tee /dev/fd/3

echo "Cloning Git Repos..." | tee /dev/fd/3
# Cloning the repos using access keys
git clone https://oauth2:${ACC_FE}@gitlab.informatik.hu-berlin.de/laya/vechta/laya-vechta-frontend.git
git clone https://oauth2:${ACC_BE}@gitlab.informatik.hu-berlin.de/laya/vechta/laya-vechta-backend.git


echo "Building LAYA Backend Docker Container..." | tee /dev/fd/3
# building docker image for Backend
#cd ../laya-vechta-backend/
#git checkout origin/constantin 

#docker build -t laya-backend:v0.0.1 .

echo "Building LAYA Frontend Container..." | tee /dev/fd/3
cd laya-vechta-frontend/
git config advice.detachedHead false # delete when master branch is ready
git checkout origin/refactor-course-edit # delete when master branch is ready to be deployed
#git pull.ff only

docker build -t laya-frontend:0.0.1 .

cd ..
echo "Setting up Docker Swarm for LAYA..." | tee /dev/fd/3

docker stack deploy -c laya-stack.yaml test 


echo "Removing all unneccessary files..." | tee /dev/fd/3
sudo rm -rf laya-vechta-backend 
sudo rm -rf laya-vechta-frontend







