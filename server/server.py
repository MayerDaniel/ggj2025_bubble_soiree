from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.websockets import WebSocketState
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse
from pprint import pprint
import json
import os
import qrcode
import socket
import psutil

def get_local_ip_starting_with(prefix="192.168"):
    # Retrieve all network interfaces and their IP addresses
    interfaces = psutil.net_if_addrs()
    
    for interface_name, interface_addresses in interfaces.items():
        for address in interface_addresses:
            if address.family == socket.AF_INET:  # Check for IPv4 addresses
                ip_address = address.address
                if ip_address.startswith(prefix):
                    return ip_address
    
    return None  # Return None if no matching IP is found

ip_address = get_local_ip_starting_with("192.168")
print(f"Starting server at {ip_address}:8000")
if ip_address is None:
    ip_address = "192.168.0.5"

url = f"http://{ip_address}:8000"

app = FastAPI()
message_store = {}  # Dictionary to store messages with an int ID as the key
message_id_counter = 1  # Counter for unique message IDs
connected_websockets = set()  # Track all connected WebSocket clients

# Generate a QR code for the URL
# Create a QR Code object
qr = qrcode.QRCode(
    version=1,  # Controls the size of the QR Code (1 is the smallest)
    error_correction=qrcode.constants.ERROR_CORRECT_L,  # Error correction level
    box_size=10,  # Size of each box in the QR code grid
    border=4,  # Thickness of the border (minimum is 4)
)

# Add data to the QR code
qr.add_data(url)
qr.make(fit=True)

# Create an image of the QR code
img = qr.make_image(fill_color="black", back_color="white")

# Save the QR code as an image file
img.save("static/qrcode.png")

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

@app.get("/computer")
async def get():
    with open("computer.html", "r") as file:
        html_content = file.read()
    return HTMLResponse(content=html_content)

# WebSocket route
# TODO: Implement singaling out the host from the guests
@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    global message_store
    global message_id_counter

    await websocket.accept()
    connected_websockets.add(websocket)

    try:
        while True:
            data = await websocket.receive_text()
            json_data = json.loads(data)

            if json_data["type"] in {"question", "poll"}:
                # Add a unique ID to the message
                message_id = message_id_counter
                json_data["id"] = message_id
                if json_data["type"] == "question":
                    message_store[message_id] = {
                        "type": "question",
                        "responses": []
                    }
                if json_data["type"] == "poll":
                    message_store[message_id] = { 
                        "type": "poll",
                        "responses": {
                            k: {
                            "value": v, 
                            "count": 0
                            } for k,v in json_data["answers"].items() 
                        }
                    }
                message_id_counter += 1
                pprint(message_store)
            
            if json_data["type"] == "response":
                # Find the message by ID and add the answer
                message_id = json_data["data"]["target"]
                if message_id not in message_store:
                    continue
                print(message_store[message_id])
                if message_store[message_id]["type"] == "question":
                    answers = message_store[message_id]["responses"]
                    answers.append(json_data["data"]["answer"])
                    message_store[message_id]["responses"] = answers
                
                elif message_store[message_id]["type"] == "poll":
                    answers = message_store[message_id]["responses"]
                    answers[str(json_data["data"]["answer"])]["count"] += 1
                    message_store[message_id]["responses"] = answers
                json_data = {
                    'type': 'response',
                    'new_data':json_data["data"],
                    'all_data': message_store[message_id]
                }

            # Broadcast the message to all connected WebSockets
            pprint(message_store)
            await broadcast_message(json_data)
    except WebSocketDisconnect:
        connected_websockets.remove(websocket)
        print("WebSocket disconnected")


async def broadcast_message(message):
    """Send a message to all connected WebSocket clients."""
    disconnected_clients = []
    for client in connected_websockets:
        if client.client_state == WebSocketState.CONNECTED:
            try:
                await client.send_json(message)
            except Exception:
                disconnected_clients.append(client)

    # Remove disconnected clients
    for client in disconnected_clients:
        connected_websockets.remove(client)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)