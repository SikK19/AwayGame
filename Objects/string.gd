extends Area2D

@export var connected_objects:Array[Node2D]

func interact(bird):
	print("string activated")
	for o in connected_objects:
		o.activate()
	#TODO: change to snapped rope instead
	queue_free()





