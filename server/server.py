from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse
import json
import os

app = FastAPI()

# Mount the static folder for serving frontend files
static_folder = "static"
os.makedirs(static_folder, exist_ok=True)
app.mount("/static", StaticFiles(directory=static_folder), name="static")

# Serve an HTML page from a separate file
@app.get("/")
async def get():
    with open("phone.html", "r") as file:
        html_content = file.read()
    return HTMLResponse(content=html_content)

# WebSocket route
# TODO: Implement singaling out the host from the guests
@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_text()
            json_data = json.loads(data)
            print(f"Message received: {json_data}")
            await websocket.send_json(json_data)
    except WebSocketDisconnect:
        print("WebSocket disconnected")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)