extends SpellObject

func _ready() -> void:
	print("blehe")
	var objects = get_tree().get_nodes_in_group("magnetable")
	for I in objects:
		if I is RigidBody2D:
			if I.global_position.distance_to(jerboa.global_position) < 4000:
				I.apply_impulse(I.global_position.direction_to(jerboa.global_position) * 300000)
