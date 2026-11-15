extends Node2D

var inputStream = []

@export var pallete := [Color.RED,Color.AQUA]

var spellDist = 200
var dt = 0

@export var jerboa : JerboaPlayer



func _process(delta: float) -> void:
	dt += delta
	if inputStream.size() <= 8:
		if Input.is_action_just_pressed("a"):
			inputStream.append(0)
		if Input.is_action_just_pressed("b"):
			inputStream.append(1)
	
	if Input.is_action_just_pressed("down") and inputStream.size() > 0:
		if GlobalVars.Spells.get(inputStream,null):
			if GlobalVars.unlockedSpells.has(inputStream):
				var new = GlobalVars.Spells.get(inputStream).instantiate()
				new.jerboa = jerboa
				add_sibling(new)
		
		inputStream.clear()
		for I in get_children(): I.queue_free()
	
	render(delta)

func render(delta):

	for I in range(inputStream.size() - get_children().size()):
		var newNode = Sprite2D.new()
		add_child(newNode)
		newNode.modulate = pallete[inputStream[get_children().size() - 1]]
		newNode.texture = load("res://art/ball.png")
		newNode.scale = Vector2.ONE * 5.6
	
	for I in range(get_children().size()):
		var angle = I / float(inputStream.size() - 1)
		if I == 0 and inputStream.size() == 1:
			angle = 0.5
		angle = lerp(0.5,PI - 0.5,angle)
		get_child(I).position = lerp(get_child(I).position,Vector2.ZERO - Vector2.from_angle(angle) * (spellDist + sin((dt * 5) + I * 30) * 10) , delta * 7)
