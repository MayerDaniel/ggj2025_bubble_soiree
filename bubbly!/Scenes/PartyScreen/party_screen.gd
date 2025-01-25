extends Control

@export var Promp_and_answers_scene : PackedScene
@export var answer_card : PackedScene
@export var poll_scene : PackedScene

@export var web_socket_url : String = "ws://localhost:8000/ws"
var socket : WebSocketPeer = WebSocketPeer.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#socket.connect_to_url(web_socket_url)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#socket.poll()
	#var state = socket.get_ready_state()
	#if state == WebSocketPeer.STATE_OPEN:
		#while socket.get_available_packet_count():
			#var _packet = socket.get_packet()
			#print("Packet: ", _packet)
			##print("Packet: ", _packet.get_string_from_utf8())
	#elif state == WebSocketPeer.STATE_CLOSING:
		## Keep polling to achieve proper close.
		#pass
	#elif state == WebSocketPeer.STATE_CLOSED:
		#var code = socket.get_close_code()
		#var reason = socket.get_close_reason()
		#print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		#set_process(false) # Stop processing.
	pass






var example_json : Dictionary = {
	"type": "poll",
	"data": {
		"question": "Fruitcake good or bad?",
		"answers": {
			1: "yes",
			2: "no"
		}
	}
}

var example_json2 : Dictionary = {
	"type": "response",
	"data": {
		"target": "<some ID for the poll, probably just an int>",
		"answer": 1
	}
}
