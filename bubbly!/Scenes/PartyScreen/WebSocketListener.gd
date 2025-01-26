extends Node


@export var web_socket_url : String = "ws://127.0.0.1:8000/ws" ##this needs to specify the IPv4 localhost or else it takes ~20 seconds to connect per Godot engine issue #67969
var socket : WebSocketPeer = WebSocketPeer.new()

func create_question(question, id):
	print("Question created! Question: %s, id: %s" % [question, id])
	# Put actual logic here
	pass

func create_poll(question, dict_of_answers, id):
	print("Poll created! Question: %s, Answers: %s, id: %s" % [question, dict_of_answers, id])
	# Put actual logic here
	pass

func create_announcement(announcement):
	print("Announcement created! Message: %s" % announcement)
	# Put actual logic here
	pass

func log_response(id, answer):
	print("Response logged! id: %s, Answer: %s" % [id, answer])
	# Put actual logic here
	pass

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
		
		while socket.get_available_packet_count():
			var _packet = socket.get_packet()
			var json_raw = _packet.get_string_from_utf8()
			var json = JSON.new()
			var error = json.parse(json_raw)
			if error == OK:
				var data_received = json.data
				if 'type' not in data_received:
					continue
				print(data_received['type'])
				match data_received['type']:
					'question':
						create_question(
							data_received['question'],
							data_received['id']
							)
					'announcement':
						create_announcement(data_received['announcement'])
					'poll':
						create_poll(
							data_received['question'],
							data_received['answers'],
							data_received['id']
						)
					'response':
						log_response(
							data_received['new_data']['target'],
							data_received['new_data']['answer']
						)
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
