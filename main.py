# main.py
from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np

# Load model
model = joblib.load("iris_model.pkl")

# FastAPI app
app = FastAPI()

# Request schema
class IrisRequest(BaseModel):
    features: list[float]

# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Sklearn Model Serving with FastAPI"}

# Prediction endpoint
@app.post("/predict")
def predict(request: IrisRequest):
    features = np.array(request.features).reshape(1, -1)
    prediction = model.predict(features)
    return {"prediction": int(prediction[0])}
