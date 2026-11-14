extends Area2D

@export var zoom = 1.0

func _on_body_entered(body: Node2D) -> void:
	if body is JerboaPlayer:
		body.flatlineZoom = zoom
