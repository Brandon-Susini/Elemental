extends State
class_name PlayerLand

@export var player : CharacterBody2D
@onready var anim = player.get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func enter():
	anim.animation = "land"
	anim.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta):
	if abs(player.velocity.x) == 0 && player.is_on_floor() && anim.frame_progress == 1.0:
		transitioned.emit(self, 'idle')
	if abs(player.velocity.x) > 0 && player.is_on_floor():
		transitioned.emit(self, 'run')
	if player.velocity.y < 0:
		transitioned.emit(self, 'jump')
