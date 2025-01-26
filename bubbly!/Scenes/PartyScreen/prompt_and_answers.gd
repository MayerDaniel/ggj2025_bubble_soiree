extends VBoxContainer

@onready var prompt_box : MarginContainer = get_node("PromptBox")
@onready var prompt_text_label : RichTextLabel = get_node("PromptBox/MarginContainer/RichTextLabel")
@onready var answers_box : HFlowContainer = get_node("AnswersFlowBox")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_prompt_text(_text: String):
	prompt_text_label.text = _text


func attach_answer_card(_node): 
	answers_box.add_child(_node)
