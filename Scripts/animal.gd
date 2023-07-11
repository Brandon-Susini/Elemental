extends Area2D

@export var speed = 100
var screen_size
var target
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	target = Vector2(screen_size.x/2,screen_size.y/2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if randi() % 10 > 7:
		target = get_new_point()
		pass
#	var velocity = position.distance_to(target)
#	distance_to()
#	if velocity.length() < 20:
#		target = get_new_point()
#		return
#	position += (velocity * speed) * delta
	position = position.move_toward(target,speed*delta)
	pass


func get_new_point():
	return Vector2(randf_range(20,screen_size.x),randf_range(20,screen_size.y))
