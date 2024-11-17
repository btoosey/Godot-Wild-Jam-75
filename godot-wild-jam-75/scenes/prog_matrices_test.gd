extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const PROGRESSIVE_MATRICES_1 = preload("res://assets/sprites/progressive-matrices/progressive_matrices_1.png")
const PROGRESSIVE_MATRICES_2 = preload("res://assets/sprites/progressive-matrices/progressive_matrices_2.png")
const PROGRESSIVE_MATRICES_3 = preload("res://assets/sprites/progressive-matrices/progressive_matrices_3.png")
const PROGRESSIVE_MATRICES_4 = preload("res://assets/sprites/progressive-matrices/progressive_matrices_4.png")

@onready var buttons: Control = $Buttons

@onready var slide_1: Control = $Buttons/Slide1
@onready var slide_2: Control = $Buttons/Slide2
@onready var slide_3: Control = $Buttons/Slide3
@onready var slide_4: Control = $Buttons/Slide4


var current_slide: int = 0
var number_correct: int = 0

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	for slide in buttons.get_children():
		for button in slide.get_children():
			button.pressed.connect(_answer_pressed.bind(button.is_correct))

func _on_dialogic_signal(argument:String):
	if argument == "start_test_2":
		self.show()
		Movement.move_to_monitor()

func _answer_pressed(correct) -> void:
	if correct:
		number_correct += 1
	if current_slide < 3:
		current_slide += 1
		next_slide()
	else:
		next_test()

func next_slide() -> void:
	if current_slide == 1:
		sprite_2d.texture = PROGRESSIVE_MATRICES_2
		slide_2.show()
	if current_slide == 2:
		sprite_2d.texture = PROGRESSIVE_MATRICES_3
		slide_3.show()
	if current_slide == 3:
		sprite_2d.texture = PROGRESSIVE_MATRICES_4
		slide_4.show()

func next_test() -> void:
	Movement.move_to_scientist()
	await get_tree().create_timer(1.6).timeout
	self.hide()
	Dialogic.VAR.prog_matrices_score = number_correct
	Dialogic.start("after_test_2")
