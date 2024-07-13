extends Area2D

@export var activated_texture:Texture2D
@export var unactivated_texture:Texture2D


func _ready():
	$activated.texture = activated_texture
	$unactivated.texture = unactivated_texture
	
	
	
	
	
func interact(player):
	print("test interact")
