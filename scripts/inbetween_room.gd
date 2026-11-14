extends Node2D

@export var itemAreas : Array[UpgradeUnlockers] = []

func _process(delta: float) -> void:
	var hovering = false
	for I in itemAreas:
		if is_instance_valid(I):
			if I.hovering:
				hovering = I
	
	if hovering:
		if hovering is UpgradeUnlockers:
			$CanvasLayer/ToGet.text = "Press [UP] to get"
			$CanvasLayer/Name.text = GlobalVars.SpellSource[hovering.upgrade]["name"]
			$CanvasLayer/Desc.text = GlobalVars.SpellSource[hovering.upgrade]["desc"]
	else:
		$CanvasLayer/Name.text = ""
		$CanvasLayer/Desc.text = ""
		$CanvasLayer/ToGet.text = ""


func _onchosen(upgrade : int) -> void:
	for I in itemAreas:
		I.queue_free()
	GlobalVars.unlockedSpells.append(GlobalVars.SpellSource[upgrade]["code"])
	#print(GlobalVars.unlockedSpells)
	
	var chosenRoom = GlobalVars.getValidRooms().pick_random()
	if chosenRoom != null:
		
		var node = load(GlobalVars.rooms[chosenRoom]["path"]).instantiate()
		add_child(node)
		node.global_position = $Exit.global_position - node.find_child("EntrancePoint").position
		
		var newInbetween = load("res://scenes/inbetween_room.tscn").instantiate()
		add_child(newInbetween)
		newInbetween.global_position = node.find_child("ExitPoint").global_position - newInbetween.find_child("Entry").position
	
	$ColorRect.queue_free()
