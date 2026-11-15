extends CanvasLayer

func _ready() -> void:
	GlobalVars.unlockedSpellsChanged.connect(render)
	
func render():
	print("yoyoyo")
	for I in $VBoxContainer.get_children():
		I.queue_free()
	
	for I in GlobalVars.SpellSource:
		if I["code"] in GlobalVars.unlockedSpells:
			var newcode :=RichTextLabel.new()
			newcode.bbcode_enabled = true
			newcode.fit_content = true
			newcode.text = I["desc"]
			$VBoxContainer.add_child(newcode)
			newcode.add_theme_constant_override("outline_size",16)
