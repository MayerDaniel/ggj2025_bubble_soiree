extends Node


@export var web_socket_url : String = "ws://localhost:8000/ws"
var socket : WebSocketPeer = WebSocketPeer.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var err = socket.connect_to_url(web_socket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	else:
		# Wait for the socket to connect.
		await get_tree().create_timer(2).timeout

		# Send data.
		#socket.send_text("Test packet")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	socket.poll()
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		
		#create_poll(question, array_of_answers, id)
		#create_question(question, id)
		#create_announcement(announcement)
		#answer_question(id, answer)
		#answer_poll(id, answer)
		while socket.get_available_packet_count():
			var _packet = socket.get_packet()
			var json_raw = _packet.get_string_from_utf8()
			var json = JSON.new()
			var error = json.parse(json_raw)
			if error == OK:
				var data_received = json.data
				print(data_received['type'])
			print("Packet: ", _packet.get_string_from_utf8())
			#print("Packet: ", _packet.get_string_from_utf8())
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false) # Stop processing.
	pass
