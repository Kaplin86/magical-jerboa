extends Node2D

var dt = 0.0

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _process(delta: float) -> void:
	dt += delta
	$Logo.global_position = Vector2(570,182 + sin(dt * 4) * 4)
	$Logo/Purewhitejerboa.position.y = (sin(dt*12) * 5) + -39.758


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
