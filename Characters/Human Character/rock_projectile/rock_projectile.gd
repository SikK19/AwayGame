extends RigidBody2D



func _on_hitbox_area_entered(area):
	area.interact(area)


func _on_sleeping_state_changed():
	if (sleeping):
		$despawnTimer.start()


func _on_despawn_timer_timeout():
	self.queue_free()
	
func set_frame(frame):
	$Sprite2D.frame = frame
