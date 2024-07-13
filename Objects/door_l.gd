extends Area2D


func interact(player):
	
	
	if player.has_key:
		$door.play("default")
		$StaticBody2D/CollisionShape2D.disabled = true
		#$StaticBody2D.queue_free()
		set_collision_layer_value(4, false)
		#TODO: add remove key function to player, to change the animation
		player.loose_key()
	else:
		pass
		#TODO: sound feedback
