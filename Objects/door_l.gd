extends Area2D


func interact(player):
	$door.play("default")
	
	if player.has_key:
		$StaticBody2D.queue_free()
		set_collision_layer_value(4, false)
		#TODO: add remove key function to player, to change the animation
		player.has_key = false
	else:
		pass
		#TODO: sound feedback
