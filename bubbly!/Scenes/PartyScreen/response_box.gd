extends PanelContainer

@onready var answer_label: RichTextLabel = get_node("MarginContainer/RichTextLabel")



# Called when the node enters the scene tree for the first time.
func _ready():
	answer_label.get_v_scroll_bar().allow_greater = true
	answer_label.get_v_scroll_bar().step = 0.01
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#vertical_auto_scroll_with_rescroll()
	pass
func _physics_process(delta):
	vertical_auto_scroll_with_rescroll()
	pass

func set_answer_text(_answer_text):
	answer_label.text = _answer_text

func vertical_auto_scroll_with_rescroll():
	var scroll_bar = answer_label.get_v_scroll_bar()
	var current_scroll_value: float = scroll_bar.value
	if current_scroll_value >= scroll_bar.max_value:
		scroll_bar.value = scroll_bar.min_value
	else:
		current_scroll_value += 0.35
		scroll_bar.value = current_scroll_value
	
