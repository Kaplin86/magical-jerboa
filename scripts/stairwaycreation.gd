extends SpellObject

func _ready() -> void:
	if !jerboa.left:
		global_position = jerboa.global_position + Vector2(250,0)
	else:
		global_position = jerboa.global_position - Vector2(250,0)
	await get_tree().create_timer(20).timeout
	queue_free()
