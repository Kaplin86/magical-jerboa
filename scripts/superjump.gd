extends SpellObject
class_name SuperJump

func _ready() -> void:
	global_position = jerboa.global_position
	$CPUParticles2D.emitting = true
	jerboa.velocity.y = -6000
