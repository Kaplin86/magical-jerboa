extends CanvasLayer

func transition(toScene : String):
	var mat : ShaderMaterial = %Shader.material
	mat.set_shader_parameter("fall_progress",1.0)
	mat.set_shader_parameter("edge_brightness",0.0)
	var newTween = create_tween()
	newTween.tween_property(%Shader, "material:shader_parameter/fall_progress", 0.0, 1)
	await newTween.finished
	mat.set_shader_parameter("edge_brightness",2)
	get_tree().change_scene_to_file(toScene)
	newTween = create_tween()
	$TextureRect.visible = true
	newTween.tween_property(%Shader, "material:shader_parameter/fall_progress", 1.0, 1)
	
