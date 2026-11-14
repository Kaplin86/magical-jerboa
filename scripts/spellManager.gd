extends Node2D

var inputStream = []

var pallete = [Color.RED * 3,Color.AQUA*3]

var spellDist = 200
var dt = 0

@export var jerboa : JerboaPlayer

var Spells = {
	[0,1,0] : preload("res://scenes/spells/superjump.tscn"),
	[1,0,0] : preload("res://scenes/spells/stairwaycreation.tscn"),
}

func _process(delta: float) -> void:
	dt += delta
	if inputStream.size() <= 8:
		if Input.is_action_just_pressed("a"):
			inputStream.append(0)
		if Input.is_action_just_pressed("b"):
			inputStream.append(1)
	
	if Input.is_action_just_pressed("down") and inputStream.size() > 0:
		if Spells.get(inputStream,null):
			var new = Spells.get(inputStream).instantiate()
			new.jerboa = jerboa
			add_sibling(new)
		
		print("cast")
		inputStream.clear()
		for I in get_children(): I.queue_free()
	
	render(delta)

func render(delta):

	for I in range(inputStream.size() - get_children().size()):
		var newNode = Sprite2D.new()
		add_child(newNode)
		newNode.modulate = pallete[inputStream[get_children().size() - 1]]
		newNode.texture = load("res://icon.svg")
	
	for I in range(get_children().size()):
		var angle = I / float(inputStream.size() - 1)
		if I == 0 and inputStream.size() == 1:
			angle = 0.5
		angle = lerp(0.5,PI - 0.5,angle)
		get_child(I).position = lerp(get_child(I).position,Vector2.ZERO - Vector2.from_angle(angle) * (spellDist + sin((dt * 5) + I * 30) * 10) , delta * 7)
