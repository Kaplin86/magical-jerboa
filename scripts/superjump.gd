extends SpellObject
class_name SuperJump

func _ready() -> void:
	global_position = jerboa.global_position
	$CPUParticles2D.emitting = true
	jerboa.velocity += Vector2(0,-6000)
