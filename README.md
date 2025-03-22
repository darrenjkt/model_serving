# Minimal serving of an Sklearn model with FastAPI

## Launch with docker
1. Launch docker container
```
# Build and spin up container 
docker compose up --build -d

# See the logs
docker logs -f modelserving
```

If you go to `localhost:1234` you should see "Sklearn Model Serving with FastAPI"

2. Get predictions via REST API call

In your local terminal, you can then run the following
```
# Get predictions
curl -X POST http://localhost:1234/predict -H "Content-Type: application/json" -d '{"features": [5.1,3.5,1.4,0.2]}'
```
You should see {"prediction":0, "message": "You can add anything else to this dict"} if successful

## Launch with Terraform
Terraform can also launch docker containers.

1. Terraform apply
```
# If you haven't done it already
terraform init

# Build image and spin up docker container
terraform apply
```

2. Get predictions
Same as above, you can then run the following
```
# Get predictions
curl -X POST http://localhost:1234/predict -H "Content-Type: application/json" -d '{"features": [5.1,3.5,1.4,0.2]}'
```
You should see {"prediction":0, "message": "You can add anything else to this dict"} if successful