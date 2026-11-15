extends Node

## THIS IS FOR ARCADE-ESQUE SYSTEMS!!

var timePassed = 0.0

func _input(event: InputEvent) -> void:
	timePassed = 0.0


func _process(delta: float) -> void:
	timePassed += delta
	if timePassed > 30:
		$Label.text = "SELF DESTRUCTING IN... \n" + str(int(35 - timePassed))
	else:
		$Label.text = ""
	if timePassed > 35:
		timePassed = 0.0
		Transition.transition("res://scenes/mainMenu.tscn")
