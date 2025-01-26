extends Control

@export var game_scene: PackedScene

@onready var start_button: TextureButton = get_node("VBoxContainer/HBoxContainer/StartButton")
@onready var quit_button: TextureButton = get_node("VBoxContainer/HBoxContainer/QuitButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(game_scene)

func _on_quit_button_pressed():
	get_tree().quit()
