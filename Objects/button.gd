extends Area2D

@export var conected_objects:Array[Node2D]


func interact(player):
	for o in conected_objects:
		o.activate()