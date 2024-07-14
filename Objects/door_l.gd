extends Area2D

var is_open = false

func activate(_state = false):
	if is_open:
		close()
	else:
		open()

func interact(player):	
	if player.has_key && not is_open:	
		open()
		player.loose_key()
	if is_open:
		close()
		#TODO: sound feedback
		
func open():
	$door.play("open")
	$AudioStreamPlayer2D.play()
	$StaticBody2D/CollisionShape2D.disabled = true
	#$StaticBody2D.queue_free()
	set_collision_layer_value(4, false)
	is_open = true
	
func close():
	$door.play("close")
	var time_in_seconds = 0.8
	await get_tree().create_timer(time_in_seconds).timeout
	$AudioStreamPlayer2D.play()
	$StaticBody2D/CollisionShape2D.disabled = false
	#$StaticBody2D.queue_free()
	set_collision_layer_value(4, true)
	is_open = false
	
