extends State
class_name PlayerKnockback

# Signal to lock controls for player
signal takeControl
# Signal to give control back to player
signal giveControl

@export var player : CharacterBody2D
@onready var anim = player.get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func enter():
	takeControl.emit()
	# Get Perpendicular vector to the collision
	var norm = player.get_last_slide_collision().get_normal()
	# Create the jump vector from our normal vector
	player.velocity = Vector2(norm.x,-1).normalized() * player.jump_height
	# Apply the jump immedietly to prevent switching out of 
	# wall jump state immedietly
	player.move_and_slide()
	# Set animation to "jump" since we are no longer wall sliding
	anim.animation = "jump"
	# Start the animation over from the beginning
	anim.play()


func exit():
	giveControl.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta):
	# If the player touches another wall transition to wall slide
	if player.is_on_wall():
		transitioned.emit(self,"wallslide")
	# If player lands go back to idle
	if player.is_on_floor():
		transitioned.emit(self,'idle')
