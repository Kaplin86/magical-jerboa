extends CharacterBody2D
class_name JerboaPlayer

var jumpPower = 3
var horizSpeed = 300

func _physics_process(delta: float) -> void:
	if is_on_floor():
		var input = false
		if Input.is_action_pressed("right"):
			velocity -= Vector2(-horizSpeed,1000 * jumpPower)
		elif Input.is_action_pressed("left"):
			velocity -= Vector2(horizSpeed,1000 * jumpPower)
		if !input:
			velocity.x = lerp(velocity.x,0.0,delta * 5)
	if !is_on_floor():
		velocity += get_gravity()
	
	$Icon.flip_h = velocity.x < 0
	move_and_slide()
