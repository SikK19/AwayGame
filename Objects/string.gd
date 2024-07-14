extends Area2D

@export var connected_objects:Array[Node2D]

func interact(_bird):
	for o in connected_objects:
		o.activate()
	$string_full.visible = false
	$string_cut.visible = true
	$CollisionShape2D.set_deferred("disabled", true)
