
extends StaticBody2D

@export var starting_state:bool = true

func _ready():
	$TextureRect.visible = starting_state
	set_collision_layer_value(7,starting_state)
	
	$TextureRect.size = $CollisionShape2D.shape.size
	$TextureRect.position = $CollisionShape2D.position - $CollisionShape2D.shape.size/2
	


func activate():
	$TextureRect.visible = not $TextureRect.visible
	set_collision_layer_value(7,not get_collision_layer_value(7))

