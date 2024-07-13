extends CharacterBody2D

@export var SPEED = 250.0
@export var JUMP_VELOCITY = -400.0
@export var human:Node2D 

@onready var sprite_standing = $Sprite
@onready var sprite_flying = $Flying

var is_on_character = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var mouse_position = null;
var direction_flying = null;

func _physics_process(delta):
	if is_on_character == true:
		position.x = human.position.x
		position.y = human.position.y - 60
	
	if is_on_floor() && not Input.is_action_pressed("fly_to_cursor"):
		sprite_standing.visible = true
		sprite_flying.visible = false
		velocity.x = 0
	
	# Add the gravity.
	if not is_on_floor() && not is_on_character:
		velocity.y += gravity * delta
		sprite_standing.visible = false
		sprite_flying.visible = true
		sprite_flying.play("default")
		
	mouse_position = get_global_mouse_position()
	if Input.is_action_pressed("fly_to_cursor") && not is_on_character:
		direction_flying = (mouse_position - position).normalized()
		velocity = (direction_flying * SPEED)
		if abs(mouse_position.x - position.x) > 10:
			if direction_flying.x > 0.2:
				sprite_standing.flip_h = true
				sprite_flying.flip_h = true
			if direction_flying.x < -0.1:
				sprite_standing.flip_h = false
				sprite_flying.flip_h = false
				
	if Input.is_action_just_released("fly_to_cursor"):
		velocity.x = 0
		
	if Input.is_action_just_released("interact") && $interactrange.has_overlapping_areas():
		$interactrange.get_overlapping_areas()[0].interact(self)

	move_and_slide()
	
func land_on_character():
	sprite_flying.visible = false
	sprite_standing.visible = true
	is_on_character = true
	
func fly_away():
	is_on_character = false
