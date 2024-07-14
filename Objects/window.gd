extends Area2D

func interact(_rock):
	$window_full.visible = false
	$window_broken.visible = true
	
	$StaticBody2D.queue_free()
	set_collision_layer_value(4, false)
