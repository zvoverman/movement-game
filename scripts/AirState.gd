extends State

class_name AirState

@export var run_state : State
@export var slide_state : State
@export var run_animation : String
@export var crouch_animation : String

func on_enter():
	if (abs(character.velocity.x) > speed):
		speed = abs(character.velocity.x)

func state_process(delta):
	if (character.is_on_floor() and Input.is_action_pressed("crouch")):
		slide()
	elif (character.is_on_floor()):
		run()

func state_input(event : InputEvent):
	return
	
func run():
	next_state = run_state
	playback.travel(run_animation)
	
func slide():
	next_state = slide_state
	playback.travel(crouch_animation)
	
func on_exit():
	speed = 150.0

