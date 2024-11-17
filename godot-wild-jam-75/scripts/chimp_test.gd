extends Node2D

@onready var stages: Array = $Stages.get_children()

var test_active: bool = false
var current_stage: int = 1
var current_stage_selections: Array
var number_correct: int = 0
@onready var continue_button: Button = $Buttons/ContinueButton
@onready var next_button: Button = $Buttons/NextButton

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	for stage in stages:
		for number in stage.get_children():
			number.number_selected.connect(_on_number_selected)

func _on_number_selected(number):
	if current_stage_selections.is_empty():
		if number.number_value == 1:
			current_stage_selections.append(number)
			if current_stage > 1:
				hide_all_numbers()
			clear_number(number)
		else:
			next_button.show()
	elif number.number_value == current_stage_selections[-1].number_value + 1:
		current_stage_selections.append(number)
		clear_number(number)
		check_if_level_complete()
	else:
		for num in stages[current_stage - 1].get_children():
			num.hide()
		next_button.show()

func clear_number(number) -> void:
	number.selected = true
	number.hovered = false
	number.number_sprite.modulate.a = 1
	number.number_sprite.texture = number.NUMBER_HIDDEN
	number.hide()
 
func hide_all_numbers() -> void:
	for number in stages[current_stage - 1].get_children():
		number.hide_number()

func check_if_level_complete() -> void:
	if current_stage_selections.size() == stages[current_stage - 1].get_children().size():
		number_correct += 1
		print(number_correct)
		if current_stage == stages.size():
			next_button.show()
		else:
			continue_button.show()

func _on_start_button_button_down() -> void:
	$Buttons/StartButton.hide()
	stages[0].show()

func _on_continue_button_pressed() -> void:
	current_stage_selections = []
	current_stage += 1
	continue_button.hide()
	stages[current_stage - 1].show()

func _on_dialogic_signal(argument:String):
	if argument == "start_test_3":
		self.show()
		Movement.move_to_monitor()

func _on_next_button_pressed() -> void:
	Movement.move_to_scientist()
	await get_tree().create_timer(1.6).timeout
	self.hide()
	Dialogic.VAR.chimp_test_score = number_correct
	Dialogic.start("after_test_3")
