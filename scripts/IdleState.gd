extends State

class_name IdleState

@export var air_state : State
@export var walk_state : State
@export var crouch_state : State
@export var crouch_animation : String
@export var walk_animation : String
@export var jump_animation : String
	
func state_process(delta):
	character.velocity.x = lerp(character.velocity.x, 0.0, 0.2)
	if (Input.is_action_pressed("crouch")):
		crouch()
	if (Input.is_action_pressed("jump")):
		jump()
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		walk()

#func state_input(event : InputEvent):
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func walk():
	next_state = walk_state
	playback.travel(walk_animation)
	
func crouch():
	next_state = crouch_state
	playback.travel(crouch_animation)
