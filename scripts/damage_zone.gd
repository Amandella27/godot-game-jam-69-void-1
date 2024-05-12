extends Area3D



func _on_body_entered(body):

	if body.is_in_group("player"):
		get_tree().call_deferred("reload_current_scene")
	
	elif body.is_in_group("asteroids"):
		body.queue_free()
	
