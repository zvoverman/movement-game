extends State

class_name RunState

@export var idle_state : State
@export var air_state : State
@export var slide_state : State
@export var idle_animation : String
@export var crouch_animation : String
@export var jump_animation : String

func state_process(delta):
	if (Input.is_action_pressed("crouch")):
		slide()
	if (Input.is_action_pressed("jump")):
		jump()
	if (not Input.is_action_pressed("left") and not Input.is_action_pressed("right")):
		idle()
		

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
	
func idle():
	next_state = idle_state
	playback.travel(idle_animation)
	
func slide():
	next_state = slide_state
	playback.travel(crouch_animation)

