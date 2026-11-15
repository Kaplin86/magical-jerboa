extends SpellObject

var target
var dt = 1.0

func _ready() -> void:
	global_position = jerboa.global_position
	var cast = $RayCast2D
	jerboa.add_child(cast)
	cast.add_exception(jerboa)
	cast.force_raycast_update()
	if cast.is_colliding(): target = cast.get_collision_point()
	cast.queue_free()

func _process(delta: float) -> void:
	if target:
		dt *= 1.2
		jerboa.velocity = jerboa.global_position.direction_to(target) * 800 * dt
		
		if jerboa.global_position.distance_squared_to(target) < 4000:
			target = null
			jerboa.process_mode = Node.PROCESS_MODE_DISABLED
			await get_tree().create_timer(0.25).timeout
			jerboa.velocity = Vector2.ZERO
			jerboa.process_mode = Node.PROCESS_MODE_INHERIT
			queue_free()
