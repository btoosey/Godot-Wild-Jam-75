extends Control

@onready var menu_background: TextureRect = $MenuBackground
@onready var button: Button = $Button
@onready var eye_upper: TextureRect = $Eyes/EyeUpper
@onready var eye_lower: TextureRect = $Eyes/EyeLower

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_button_pressed() -> void:
	button.disabled = true
	close_eyes()
	await get_tree().create_timer(2).timeout
	button.hide()
	menu_background.hide()
	Dialogic.start("intro")

func close_eyes() -> void:
	var upper_tween = get_tree().create_tween()
	upper_tween.tween_property(eye_upper, "position", Vector2(0, 0), 1.8).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)

	var lower_tween = get_tree().create_tween()
	lower_tween.tween_property(eye_lower, "position", Vector2(0, 0), 1.8).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)

func open_eyes() -> void:
	var upper_tween = get_tree().create_tween()
	upper_tween.tween_property(eye_upper, "position", Vector2(0, -360), 1.8).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)

	var lower_tween = get_tree().create_tween()
	lower_tween.tween_property(eye_lower, "position", Vector2(0, 360), 1.8).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUART)

func _on_dialogic_signal(argument:String):
	if argument == "open_eyes":
		open_eyes()
