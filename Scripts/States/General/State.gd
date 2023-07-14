extends Node
class_name State

# Signal to emit when switching out of this state
signal transitioned


# Called when this state is switched to current state
func enter():
	pass


# Called when this state is switched out of current state
func exit():
	pass
	

# Called every frame where this state is the current state
func update(delta: float):
	pass
	

# Called every physics tick where this state is the current state
func physics_update(delta: float):
	pass
