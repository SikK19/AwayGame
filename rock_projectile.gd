extends RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_area_entered(area):
	area.interact()


func _on_sleeping_state_changed():
	if (sleeping):
		$despawnTimer.start()


func _on_despawn_timer_timeout():
	self.queue_free()
