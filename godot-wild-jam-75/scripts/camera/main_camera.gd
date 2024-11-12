extends Camera2D

@export var scrolling: bool = false

@export var left_boundary: float = -40.0
@export var right_boundary: float = 700.0

@export var camera_speed: float = 240

func _ready() -> void:
	position = Vector2(320,180)
	
func _process(delta: float) -> void:
	if not scrolling:
		return

	if Input.is_action_pressed("look_left"):
		var new_position = position.x - camera_speed * delta
		position.x = clamp(new_position, left_boundary, right_boundary)

	if Input.is_action_pressed("look_right"):
		var new_position = position.x + camera_speed * delta
		position.x = clamp(new_position, left_boundary, right_boundary)
