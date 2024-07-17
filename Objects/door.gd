extends Area2D

var is_open = false
@export var locked = false

func activate(_state = false):
	if is_open:
		close()
	else:
		open()

func interact(player):	
	if is_open:
		close()
	elif not locked:
		open()
	elif  player.has_key:	
		open()
		player.loose_key()
		locked = false
	
		
func open():
	$door.play("open")
	if !$SoundOpenDoor.playing:
		$SoundOpenDoor.play()
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	#$StaticBody2D.queue_free()
	#set_collision_layer_value(4, false)
	is_open = true
	
func close():
	$door.play("close")
	var time_in_seconds = 0.5
	await get_tree().create_timer(time_in_seconds).timeout
	if !$SoundCloseDoor.playing:
		$SoundCloseDoor.play()
	$StaticBody2D/CollisionShape2D.disabled = false
	#$StaticBody2D.queue_free()
	#set_collision_layer_value(4, true)
	is_open = false
