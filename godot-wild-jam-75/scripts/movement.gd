extends Node

var camera = null

func _ready() -> void:
	var root = get_tree().root
	camera = root.get_child(2).get_child(2)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "allow_movement":
		enable_scrolling()

func move_to_monitor() -> void:
	camera.move_to_monitor()

func move_to_scientist() -> void:
	camera.move_to_scientist()

func enable_scrolling() -> void:
	camera.scrolling = true

func disable_scrolling() -> void:
	camera.scrolling = false
