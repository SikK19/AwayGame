extends Area2D

@export var conected_objects:Array[Node2D]

func interact():
	for o in conected_objects:
		o.activate()
	#TODO: change to snapped rope instead
	queue_free()





