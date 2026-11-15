extends Node2D

@export var itemAreas : Array[UpgradeUnlockers] = []

func _ready() -> void:
	var options = GlobalVars.getGainableSpeller()
	var choice0 = options.pick_random()
	options.erase(choice0)
	var choice1 = options.pick_random()
	options.erase(choice1)
	var choice2 = options.pick_random()
	options.erase(choice2)
	var full = [choice0,choice1,choice2]
	print(full)
	var valid = false

	for I in itemAreas:
		var option = full.get(itemAreas.find(I))
		if option != null:
			I.upgrade = option
			I._ready()
			valid = true
		else:
			I.queue_free()
	
	if !valid:
		_onchosen(-1)

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
		if is_instance_valid(I):
			I.queue_free()
	if upgrade != -1:
		GlobalVars.unlockedSpells.append(GlobalVars.SpellSource[upgrade]["code"])
	#print(GlobalVars.unlockedSpells)
	
	var chosenRoom = GlobalVars.getValidRooms().pick_random()
	if chosenRoom != null:
		GlobalVars.playedRooms.append(chosenRoom)
		var node = load(GlobalVars.rooms[chosenRoom]["path"]).instantiate()
		add_child(node)
		node.global_position = $Exit.global_position - node.find_child("EntrancePoint").position
		
		var newInbetween = load("res://scenes/inbetween_room.tscn").instantiate()
		add_child(newInbetween)
		newInbetween.global_position = node.find_child("ExitPoint").global_position - newInbetween.find_child("Entry").position
		
		
	
	$ColorRect.queue_free()
