extends CharacterBody2D


@export var SPEED = 250.0
@export var JUMP_VELOCITY = -400.0

@onready var spriteStanding = $Sprite
@onready var spriteFlying = $Flying


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var mouse_position = null;
var direction_flying = null;


func _physics_process(delta):
	if is_on_floor() && not Input.is_action_pressed("fly_to_cursor"):
		spriteStanding.visible = true
		spriteFlying.visible = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		spriteStanding.visible = false
		spriteFlying.visible = true
		spriteFlying.play("default")
		
	mouse_position = get_global_mouse_position()
	if Input.is_action_pressed("fly_to_cursor"):
		direction_flying = (mouse_position - position).normalized()
		velocity = (direction_flying * SPEED)
		if direction_flying.x > 0:
			spriteStanding.flip_h = true
			spriteFlying.flip_h = true
		if direction_flying.x < 0:
			spriteStanding.flip_h = false
			spriteFlying.flip_h = false
			
	if Input.is_action_just_released("fly_to_cursor"):
		velocity.x = 0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
