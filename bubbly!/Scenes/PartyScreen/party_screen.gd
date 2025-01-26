extends Control

@export var promp_and_answers_scene : PackedScene
@export var answer_card : PackedScene
@export var poll_scene : PackedScene


@onready var big_board : VBoxContainer = get_node("%BigBoard")

var questions_with_id : Array[Dictionary]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

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

func log_response(id, answer):
	print("Response logged! id: %s, Answer: %s" % [id, answer])
	# Put actual logic here
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
