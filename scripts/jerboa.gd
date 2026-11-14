extends CharacterBody2D
class_name JerboaPlayer

var jumpPower = 3
var horizSpeed = 300

var left = false

func _physics_process(delta: float) -> void:
	if is_on_floor():
		var input = false
		if Input.is_action_pressed("right"):
			velocity -= Vector2(-horizSpeed,1000 * jumpPower)
			left = false
		elif Input.is_action_pressed("left"):
			velocity -= Vector2(horizSpeed,1000 * jumpPower)
			left = true
		if !input:
			velocity.x = lerp(velocity.x,0.0,delta * 5)
	if !is_on_floor():
		velocity += get_gravity()
	
	$Icon.flip_h = velocity.x < 0
	move_and_slide()
	
	var dist = lerp(0.0,-0.5,(global_position.distance_to($Camera2D.get_screen_center_position()) / 700.0))
	#print($Camera2D.get_screen_center_position())
	$Camera2D.zoom = lerp($Camera2D.zoom, Vector2.ONE * (dist + 1), delta * 3)
	
