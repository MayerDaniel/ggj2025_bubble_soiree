extends PanelContainer

@onready var answer_label: RichTextLabel = get_node("MarginContainer/RichTextLabel")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_answer_text(_answer_text):
	answer_label.text = _answer_text
