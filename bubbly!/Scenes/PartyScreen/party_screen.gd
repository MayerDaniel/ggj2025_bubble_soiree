extends Control

@export var Promp_and_answers_scene : PackedScene
@export var answer_card : PackedScene
@export var poll_scene : PackedScene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
