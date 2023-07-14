extends CharacterBody2D
# Emit this signal when only touching a wall
signal wall_sliding

# Default move speed
@export var walk_speed = 200
# Speed to ramp to after continued movement (Not implemented)
@export var run_speed = 400
# Amount to add to velocity.y when inputting "jump"
@export var jump_height = 600
# Animated Sprite Object that handles animation
@onready var anim = $AnimatedSprite2D

# boolean which represents if the player has control
# Only changed when wall jumping so they can't input moves
var isControlled = false
# Project gravity setting. Defaults to 980
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	# Start playing animations right away
	anim.play()

	
# Add a state machine
func _physics_process(delta):
	# Add gravity to player every frame
	velocity.y += (gravity * delta)
	
	# If the player is moving left, flip the sprite horizontally
	# Unflip if moving right
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false
	
	# Disable controls if player is being controlled by physics
	if isControlled:
		# Apply physics forces
		move_and_slide()
		# Leave the function early
		return
	
	# Direction vector for horizontal movement.
	# -1 if left pressed, 1 if right pressed, 0 if both pressed
	var direction = Input.get_axis("left","right")
	# Multiply our direction by our speed to get horizontal velocity.
	velocity.x = direction * walk_speed
	
	# If player pressed jump button and is on a floor, add our jump
	# height to the players vertical velocity.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y -= jump_height
	
	# If the player is wallsliding, signal other scripts
	if is_on_wall_only():
		wall_sliding.emit()
	
	# Apply movement.
	move_and_slide()


func _on_debug_timer_timeout():
	pass # Replace with function body.


# When wall jump state is entered, take control from player
func _on_wall_jump_take_control():
	isControlled = true


# When wall jump state is left, give back control to the player
func _on_wall_jump_give_control():
	isControlled = false
