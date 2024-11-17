extends Camera2D

@export var scrolling: bool = false

@export var left_boundary: float = -40.0
@export var right_boundary: float = 700.0

@export var camera_speed: float = 240

func _ready() -> void:
	position = Vector2(-20,180)

func _process(delta: float) -> void:
	if not scrolling:
		return

	if Input.is_action_pressed("look_left"):
		var new_position = position.x - camera_speed * delta
		position.x = clamp(new_position, left_boundary, right_boundary)

	if Input.is_action_pressed("look_right"):
		var new_position = position.x + camera_speed * delta
		position.x = clamp(new_position, left_boundary, right_boundary)

func move_to_monitor() -> void:
	var move_tween = get_tree().create_tween()
	move_tween.tween_property(self, "position", Vector2(-20,180), 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)

func move_to_scientist() -> void:
	var move_tween = get_tree().create_tween()
	move_tween.tween_property(self, "position", Vector2(432,180), 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
