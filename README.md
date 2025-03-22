# Minimal serving of an Sklearn model with FastAPI

1. Launch docker container
```
# Build and spin up container 
docker compose up --build -d

# See the logs
docker logs -f modelserving
```

2. Get predictions via REST API call

In your local terminal, you can then run the following
```
# Get predictions
curl -X POST http://localhost:1234/predict -H "Content-Type: application/json" -d '{"features": [5.1,3.5,1.4,0.2]}'
```
You should see {"prediction":0} if successful