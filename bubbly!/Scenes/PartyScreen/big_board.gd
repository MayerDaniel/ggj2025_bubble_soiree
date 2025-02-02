extends VBoxContainer

@onready var scroll_container : ScrollContainer = get_parent()
@onready var v_scroll_bar = scroll_container.get_v_scroll_bar()

var window_size : Vector2i


func _ready():
	v_scroll_bar.allow_greater = true
	v_scroll_bar.step = 0.01
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(_delta):
	window_size = get_window().size
	vertical_auto_scroll_with_rescroll()
	pass


func set_prompt_text(_text: String):
	#prompt_text_label.text = _text
	return


func attach_answer_card(_node): 
	#answers_box.add_child(_node)
	return
	



func vertical_auto_scroll_with_rescroll():
	var scroll_bar = v_scroll_bar
	var current_scroll_value: float = scroll_bar.value
	if scroll_bar.max_value > (window_size.y * 0.95): ##this value is dependant on the size of the box and will need to be tweaked
		if current_scroll_value >= scroll_bar.max_value:
			scroll_bar.value = scroll_bar.min_value
		else:
			current_scroll_value += 0.35
			scroll_bar.value = current_scroll_value
	else: scroll_bar.value = 0
