extends CharacterBody2D
class_name JerboaPlayer

var jumpPower = 3
var horizSpeed = 300

var left = false
var flatlineZoom = 1

var lastAudio = 0.0

func _physics_process(delta: float) -> void:
	lastAudio += delta
	if is_on_floor():
		var input = false
		if Input.is_action_pressed("right"):
			velocity -= Vector2(-horizSpeed,1000 * jumpPower)
			left = false
			input = true
			var sfx = load("res://sfx/sound"+str(randi_range(2,8))+".mp3")
			var newSFX = AudioStreamPlayer2D.new()
			newSFX.stream = sfx
			add_child(newSFX)
			newSFX.play()
			newSFX.volume_db = 1
		elif Input.is_action_pressed("left"):
			print("boing")
			velocity -= Vector2(horizSpeed,1000 * jumpPower)
			left = true
			input = true
			var sfx = load("res://sfx/sound"+str(randi_range(2,8))+".mp3")
			var newSFX = AudioStreamPlayer2D.new()
			newSFX.stream = sfx
			add_child(newSFX)
			newSFX.play()
			newSFX.volume_db = 1
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
	if $Camera2D.zoom.x > 1.4:
		$DiscoLounge.volume_linear = lerp($DiscoLounge.volume_linear,0.8,delta * 20)
		$ElectroCabello.volume_linear = lerp($ElectroCabello.volume_linear,0.0,delta * 20)
	else:
		$DiscoLounge.volume_linear = lerp($DiscoLounge.volume_linear,0.0,delta * 20)
		$ElectroCabello.volume_linear = lerp($ElectroCabello.volume_linear,0.8,delta * 20)
