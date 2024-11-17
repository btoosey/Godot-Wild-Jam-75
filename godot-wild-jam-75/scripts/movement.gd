extends Node

var camera = null

func _ready() -> void:
	var root = get_tree().root
	camera = root.get_child(2).get_child(1)

func move_to_monitor() -> void:
	camera.move_to_monitor()

func move_to_scientist() -> void:
	camera.move_to_scientist()

func enable_scrolling() -> void:
	camera.scrolling = true

func disable_scrolling() -> void:
	camera.scrolling = false
