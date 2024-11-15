extends Node2D
class_name ChimpTestNumber

signal number_selected(number)

@export var chimp_test_number_data: ChimpTestNumberData : set = set_chimp_test_number_data
@onready var number_sprite: Sprite2D = $NumberSprite
const NUMBER_HIDDEN = preload("res://assets/sprites/chimp-test/number_hidden.png")

var hovered: bool = false
var selected: bool = false
var number_value: int

func set_chimp_test_number_data(value: ChimpTestNumberData) -> void:
	if not is_node_ready():
		await ready

	chimp_test_number_data = value

	number_value = chimp_test_number_data.test_number_value
	number_sprite.texture = chimp_test_number_data.test_number_sprite

func _on_area_2d_mouse_entered() -> void:
	if selected:
		return

	hovered = true
	number_sprite.modulate.a = 0.5

func _on_area_2d_mouse_exited() -> void:
	hovered = false
	number_sprite.modulate.a = 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click") and hovered:
		number_selected.emit(self)

func hide_number() -> void:
	number_sprite.texture = NUMBER_HIDDEN
