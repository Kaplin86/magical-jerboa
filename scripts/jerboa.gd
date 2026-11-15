extends CharacterBody2D
class_name JerboaPlayer

var jumpPower = 3
var horizSpeed = 300

var left = false
var flatlineZoom = 1

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
	
	

	$Icon.scale.x = lerp(-1.0,1.0,!left) * 0.365
	var lastVelocity = velocity
	move_and_slide()
	
	var dist = lerp(0.0,-0.5,(global_position.distance_to($Camera2D.get_screen_center_position()) / 700.0))
	#print($Camera2D.get_screen_center_position())
	$Camera2D.zoom = clamp(lerp($Camera2D.zoom, Vector2.ONE * (dist + flatlineZoom), delta * 3),Vector2(0.01,0.01),Vector2(2.0,2.0))
	
	if get_last_slide_collision(): 
		if abs(get_last_slide_collision().get_angle()) > 1 and abs(get_last_slide_collision().get_angle()) < 3:
			velocity.x = lastVelocity.x * 0.5
			
			velocity.x *= -1
	
	
