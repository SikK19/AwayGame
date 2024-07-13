extends CharacterBody2D

@export var SPEED = 250.0
@export var JUMP_VELOCITY = -400.0
@export var human:Node2D 

@onready var sprite_idle = $Idle
@onready var sprite_flying = $Flying
@onready var sprite_picking = $Picking

var has_key = false

var is_on_character = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var mouse_position = null
var direction_flying = null

func _ready():
	sprite_idle.visible = false
	sprite_flying.visible = false
	sprite_picking.visible = false
	if is_on_floor():
		sprite_idle.play("default")
		sprite_idle.visible = true
		sprite_flying.visible = false
	else:
		sprite_flying.play("default")
		sprite_flying.visible = true
		sprite_idle.visible = false

func _physics_process(delta):
	if is_on_character:
		sprite_flying.stop()
		position.x = human.position.x
		position.y = human.position.y - 16
	
	if is_on_floor() && not Input.is_action_pressed("fly_to_cursor"):
		sprite_idle.play("default")
		sprite_idle.visible = true
		sprite_flying.visible = false
		velocity.x = 0
	
	# Add the gravity.
	if not is_on_floor() && not is_on_character:
		velocity.y += gravity * delta
		sprite_idle.visible = false
		sprite_flying.visible = true
		sprite_flying.play("default")
		
	mouse_position = get_global_mouse_position()
	if Input.is_action_pressed("fly_to_cursor") && not is_on_character:
		direction_flying = (mouse_position - position).normalized()	
		velocity = (direction_flying * SPEED)
		if abs(mouse_position.x - position.x) > 10:
			if direction_flying.x > 0.2:
				sprite_idle.flip_h = false
				sprite_flying.flip_h = false
			if direction_flying.x < -0.1:
				sprite_idle.flip_h = true
				sprite_flying.flip_h = true
		
	if Input.is_action_just_pressed("interact") && $interactrange.has_overlapping_areas():
		$interactrange.get_overlapping_areas()[0].interact(self)
		
	if Input.is_action_just_released("fly_to_cursor") && $bird_close_to_human.has_overlapping_areas():
		print("landing")
		land_on_character()
		
	if Input.is_action_just_released("fly_to_cursor"):
		velocity.x = 0
		
	if is_on_character && Input.is_action_pressed("fly_to_cursor"):
		is_on_character = false
		human.is_bird_on_human = false
		
	if $interactrange.has_overlapping_areas() && Input.is_action_just_pressed("bird_interact"):
		$interactrange.get_overlapping_areas()[0].interact(self)
		
	if has_key && $bird_close_to_human.has_overlapping_areas():
		human.has_key = true;
		has_key = false;

	move_and_slide()
	
func land_on_character():
	sprite_flying.visible = false
	sprite_idle.visible = true
	is_on_character = true
	human.is_bird_on_human = true
	
func take_key():
	has_key = true
