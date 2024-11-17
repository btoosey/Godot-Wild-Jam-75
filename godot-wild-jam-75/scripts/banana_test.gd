extends Node2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "start_test_4":
			self.show()
			Movement.move_to_monitor()
			timer.start()

func _on_timer_timeout() -> void:
	Movement.move_to_scientist()
	await get_tree().create_timer(1.6).timeout
	self.hide()
	Dialogic.start("after_test_4")
