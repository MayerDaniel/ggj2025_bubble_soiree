extends VBoxContainer

@onready var prompt_box : MarginContainer = get_node("PromptBox")
@onready var prompt_text_label : RichTextLabel = get_node("PromptBox/MarginContainer/RichTextLabel")
@onready var answers_scroll_container : ScrollContainer = get_node("ScrollContainer")
@onready var answers_box : HBoxContainer = get_node("ScrollContainer/AnswersBox")




# Called when the node enters the scene tree for the first time.
func _ready():
	prompt_text_label.get_v_scroll_bar().allow_greater = true
	prompt_text_label.get_v_scroll_bar().step = 0.01
	answers_scroll_container.get_h_scroll_bar().allow_greater = true
	answers_scroll_container.get_h_scroll_bar().step = 0.01
	
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(_delta):
	vertical_auto_scroll_with_rescroll()
	horizontal_answer_auto_scroll()
	pass


func set_prompt_text(_text: String):
	prompt_text_label.text = _text


func attach_answer_card(_node): 
	answers_box.add_child(_node)
	



func vertical_auto_scroll_with_rescroll():
	var scroll_bar = prompt_text_label.get_v_scroll_bar()
	var current_scroll_value: float = scroll_bar.value
	if scroll_bar.max_value > 25: ##this value is dependant on the size of the box and will need to be tweaked
		if current_scroll_value >= scroll_bar.max_value:
			scroll_bar.value = scroll_bar.min_value
		else:
			current_scroll_value += 0.35
			scroll_bar.value = current_scroll_value
	else: scroll_bar.value = 0



func horizontal_answer_auto_scroll():
	var scroll_bar = answers_scroll_container.get_h_scroll_bar()
	var current_scroll_value: float = scroll_bar.value
	if scroll_bar.max_value > 700: ##this value is dependant on the size of the box and will need to be tweaked
		if current_scroll_value >= scroll_bar.max_value:
			scroll_bar.value = scroll_bar.min_value
		else:
			current_scroll_value += 0.35
			scroll_bar.value = current_scroll_value
	else: scroll_bar.value = 0
