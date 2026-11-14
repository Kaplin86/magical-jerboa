extends Area2D
class_name UpgradeUnlockers

@export var upgrade : int = 0

signal chosen(thegrade : int)

var hovering = false

func _process(delta: float) -> void:
	hovering = false
	for I in get_overlapping_bodies():
		if I is JerboaPlayer:
			hovering = true
	
	if Input.is_action_just_pressed("up"):
		for I in get_overlapping_bodies():
			chosen.emit(upgrade)

func _ready() -> void:
	$Sprite2D.texture = GlobalVars.SpellSource[upgrade].get("texture",null)
