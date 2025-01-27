extends Control

@export var promp_and_answers_scene : PackedScene
@export var answer_card : PackedScene
@export var poll_scene : PackedScene
@export var alert_box_preload : PackedScene


@onready var big_board : VBoxContainer = get_node("%BigBoard")
@onready var placement_zone : Control = get_node("PanelContainer/PlacementZone")

var questions_with_id : Array[Dictionary]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	pass


func create_question(_question_text: String, _id: int):
	var _new_question = promp_and_answers_scene.instantiate()
	big_board.add_child(_new_question)
	_new_question.set_prompt_text(_question_text)
	questions_with_id.append({"node" = _new_question, "id" = _id})
	#print("Question created! Question: %s, id: %s" % [_question_text, _id])
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



func log_response(_question_id, _answer_text):
	var _prompt_node = get_prompt_node_by_id(_question_id)
	var _new_answer = answer_card.instantiate()
	_prompt_node.attach_answer_card(_new_answer)
	_new_answer.set_answer_text(_answer_text)
	
	print("Response logged! id: %s, Answer: %s" % [_question_id, _answer_text])
	# Put actual logic here
	pass

func get_prompt_node_by_id(_prompt_id: int):
	for _node_id_pair in questions_with_id:
		if _node_id_pair["id"] == _prompt_id:
			return _node_id_pair["node"]


func create_random_alert_box(_alert_text: String):
	var _new_alert = alert_box_preload.instantiate()
	placement_zone.add_child(_new_alert)
	_new_alert.position.x = ((placement_zone.size.x/2 - _new_alert.size.x/2))
	_new_alert.position.y = ((placement_zone.size.y/2) + randf_range(-250, 250)) 
	_new_alert.set_text(_alert_text)
	_new_alert.apply_random_animation()
	
	
	
	
	

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
