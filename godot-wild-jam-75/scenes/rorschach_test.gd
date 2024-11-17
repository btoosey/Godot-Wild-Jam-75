extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const RORSCHACH_1 = preload("res://assets/sprites/rorschach-slides/rorschach_1.png")
const RORSCHACH_2 = preload("res://assets/sprites/rorschach-slides/rorschach_2.png")
const RORSCHACH_3 = preload("res://assets/sprites/rorschach-slides/rorschach_3.png")
const RORSCHACH_4 = preload("res://assets/sprites/rorschach-slides/rorschach_4.png")

@onready var buttons: Control = $Buttons
@onready var slide_1: Control = $"Buttons/Slide 1"
@onready var slide_2: Control = $"Buttons/Slide 2"
@onready var slide_3: Control = $"Buttons/Slide 3"
@onready var slide_4: Control = $"Buttons/Slide 4"

var current_slide: int = 0
var answer_1: String
var answer_2: String
var answer_3: String
var answer_4: String

func _ready() -> void:
	sprite_2d.texture = RORSCHACH_1
	for button in slide_1.get_children():
		button.pressed.connect(_on_slide_1_pressed.bind(button.text))
	for button in slide_2.get_children():
		button.pressed.connect(_on_slide_2_pressed.bind(button.text))
	for button in slide_3.get_children():
		button.pressed.connect(_on_slide_3_pressed.bind(button.text))
	for button in slide_4.get_children():
		button.pressed.connect(_on_slide_4_pressed.bind(button.text))

func _on_slide_1_pressed(text) -> void:
	answer_1 = text
	sprite_2d.texture = RORSCHACH_2
	next_slide()

func _on_slide_2_pressed(text) -> void:
	answer_2 = text
	sprite_2d.texture = RORSCHACH_3
	next_slide()

func _on_slide_3_pressed(text) -> void:
	answer_3 = text
	sprite_2d.texture = RORSCHACH_4
	next_slide()

func _on_slide_4_pressed(text) -> void:
	answer_4 = text
	next_test()

func next_slide() -> void:
	buttons.get_children()[current_slide].hide()
	current_slide += 1
	buttons.get_children()[current_slide].show()
	
func next_test() -> void:
	Movement.move_to_scientist()
