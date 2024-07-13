extends CharacterBody2D

var rock_scene = load("res://Characters/Human Character/rock_projectile/rock_projectile.tscn")
var throw_force = 1000
var can_throw = true

var facing_direction = 1
var has_key = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var bird:Node2D 
var is_bird_on_human = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		#climb ladder if at ladder, jump otherwise
		if $ladder_detector.get_overlapping_areas() > 0:
			velocity.y = SPEED
		if is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction:
		facing_direction = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	#calls the interact function on an interactable item, the interactable object does the rest
	if Input.is_action_just_pressed("interact"):
		var a = $"interact box".get_overlapping_areas()
		if a.size() > 0 and not a.size() >=2:

			a[0].interact(self)
			
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
		if is_bird_on_human:
			bird.sprite_standing.flip_h = true
		$"throwing_arm/throwing test sprite".position.x = 93
		$"throwing_arm/throwing test sprite".position.y = -2
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
		if is_bird_on_human:
			bird.sprite_standing.flip_h = false
		$"throwing_arm/throwing test sprite".position.x = -93
		$"throwing_arm/throwing test sprite".position.y = 20

	
	#play the wobbly arm
	if Input.is_action_pressed("throw") and can_throw:
		$throwing_arm/AnimationPlayer.play("throw_wobble")
	if Input.is_action_just_released("throw") and $throwing_arm/AnimationPlayer.is_playing():
		#create a new rock scene, throw it in the direction of the player is currently aiming in
		var rock = rock_scene.instantiate()
		get_parent().add_child(rock)
		rock.global_position = $throwing_arm.global_position
		rock.linear_velocity = Vector2(throw_force * facing_direction,0).rotated($throwing_arm.rotation * facing_direction)
		
		$throwing_arm/AnimationPlayer.stop()
		
		can_throw = false
		$rock_throw_cooldown.start()
		
	if $human_close_to_bird.has_overlapping_areas() && Input.is_action_just_released("ask_bird_to_land") && not is_bird_on_human:
		print("trying to land")
		bird.land_on_character()
		is_bird_on_human = true
		
	if Input.is_action_just_released("ask_bird_to_fly") && is_bird_on_human:
		bird.fly_away()
		is_bird_on_human = false


func _on_rock_throw_cooldown_timeout():
	can_throw = true
