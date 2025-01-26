extends TextureRect
var shrink_rate = 0.05  # Scale reduction per second
var velocity = Vector2(55, 30) # Initial velocity in pixels per second
@onready var window = $"../.." # Reference to the parent window (or any container node)
@onready var sad = load("res://Resources/Images/GGJ25_Sadbubble.png")
@onready var normal = load("res://Resources/Images/GGJ25_Cutebubble.png")
@onready var happy = load("res://Resources/Images/GGJ25_Happybubble.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func sad_face():
	$BubbleFace.texture = sad
	pass

func normal_face():
	$BubbleFace.texture = normal
	pass

func happy_face():
	$BubbleFace.texture = happy
	pass

func bounce_within_bounds():
	# Get the parent window size
	var window_size = window.size
	
	# Bounce on horizontal edges
	if position.x <= 0 or position.x + self.texture.get_width()*2 >= window_size.x:
		velocity.x = -velocity.x
		position.x = clamp(position.x, 0, window_size.x) # Keep the object within bounds

	# Bounce on vertical edges
	if position.y <= 0 or position.y + self.texture.get_height()*2 >= window_size.y:
		velocity.y = -velocity.y
		position.y = clamp(position.y, 0, window_size.y) # Keep the object within bounds

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Reduce the scale gradually
	if scale.x < 0.85:
		sad_face()
	elif scale.x > 1.35:
		happy_face()
	else:
		normal_face()
	
	position += velocity * delta
	bounce_within_bounds()
	
	if scale.x > 2.5:
		pass
	elif scale.x > 0 and scale.y > 0:  # Ensure it doesn't shrink to negative values
		scale -= Vector2(shrink_rate, shrink_rate) * delta
	else:
		# Optional: Stop shrinking when the object is too small
		scale = Vector2(0, 0)
		#queue_free()  # Optional: Remove the object when it shrinks to 0
		pass
