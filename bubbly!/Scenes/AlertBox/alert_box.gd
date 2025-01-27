extends Control

@onready var text_label : RichTextLabel = get_node("MarginContainer/RichTextLabel")
@onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

enum ANIMATION_MODES{LEFT_TO_RIGHT}
var animation_mode : ANIMATION_MODES
var tick_timer : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	left_to_right_animation()
	pass
func set_text(_alert_text):
	text_label.text = _alert_text

func apply_random_animation():
	animation_mode = ANIMATION_MODES.LEFT_TO_RIGHT
	
func left_to_right_animation():
	if animation_mode == ANIMATION_MODES.LEFT_TO_RIGHT:
		if tick_timer <= 0:
			position.x = -10000
			tick_timer = 1
		if tick_timer <= 60 or tick_timer >= 200:
			position.x += 167
		tick_timer +=  1
			
