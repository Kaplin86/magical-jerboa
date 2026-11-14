extends CharacterBody2D

var jumpPower = 2.0
var horizSpeed = 200

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
	print(velocity)
	move_and_slide()
