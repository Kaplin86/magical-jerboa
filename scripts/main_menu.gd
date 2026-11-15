extends Node2D

var dt = 0.0

func _on_button_pressed() -> void:
	Transition.transition("res://scenes/main.tscn")

func _process(delta: float) -> void:
	dt += delta
	$Logo.global_position = Vector2(570,182 + sin(dt * 4) * 4)
	$Logo/Purewhitejerboa.position.y = (sin(dt*12) * 5) + -39.758
	if Input.is_action_just_pressed("a"):
		_on_button_pressed()
