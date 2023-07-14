extends Node


@export var initial_state : State
var current_state: State
var states: Dictionary = {}


# Once loaded, loop through all children nodes
func _ready():
	for child in get_children():
		# If the child script extends state
		if child is State:
			# Add the node to our states dictionary 
			# with the key being its name and value being the actual object
			states[child.name.to_lower()] = child
			# Attach the 'transitioned' signal it has 
			# to this objects 'on_child_tranistion' function
			child.transitioned.connect(on_child_transition)
	
	
	# If an initial state is given in the editor
	if initial_state:
		# Call enter on it
		initial_state.enter()
		# Set the StateMachines current state to that state
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Every frame check to see if current state exists
	if current_state:
		# If it does, update it.
		current_state.update(delta)

# Same function as above but only runs on physics ticks.
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
		

# This function is called when a state reports that
# it is transitioning out.
func on_child_transition(state, new_state_name):
	#print("State Transitioned")
	#print("Current State: ", state.name.to_lower(), " transitioned to, ", new_state_name, "\n")
	
	# If the state calling this function is not our current state
	# Leave the function because that means it was an incorrect call
	if state != current_state:
		return
	
	# set new state equal to the new state passed in
	# by retreiving it from our states dictionary
	var new_state = states.get(new_state_name.to_lower())
	# If nothing was returned then there is an error so leave the function
	if !new_state:
		return
	
	# otherwise if we have a current state call exit on it
	if current_state:
		current_state.exit()
		
	# Then call enter on our new state
	new_state.enter()
	# Finally set our current state to the new state
	current_state = new_state
		
