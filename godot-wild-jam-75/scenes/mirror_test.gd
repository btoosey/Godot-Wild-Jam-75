extends Node2D

@onready var mirror_sign: Sprite2D = $MirrorSign
@onready var main_camera: Camera2D = $"../MainCamera"
@onready var chimp: Sprite2D = $Chimp

var cannot_move: bool = false
var speed: int = 120
var left_boundary: float = 0
var right_boundary: float = 950

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _process(delta: float) -> void:
	if cannot_move:
		return

	if chimp.position.x == 950:
		cannot_move = true
		Movement.disable_scrolling()
		Dialogic.start("finale")

	if Input.is_action_pressed("look_right"):
		if main_camera.position.x >= 580:
			var new_position = chimp.position.x + speed * delta
			chimp.position.x = clamp(new_position, left_boundary, right_boundary)

func _on_dialogic_signal(argument:String):
	if argument == "show_mirror_sign":
		mirror_sign.show()
