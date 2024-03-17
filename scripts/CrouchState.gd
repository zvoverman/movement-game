extends State

class_name CrouchState

@export var idle_state : State
@export var air_state : State
@export var run_state : State

@export var original_collision : CollisionShape2D
@export var crouch_collision : CollisionShape2D
@export var idle_animation : String
@export var run_animation : String
@export var jump_animation : String

func on_enter():
	original_collision.disabled = true
	crouch_collision.disabled = false

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump") or event.is_action_pressed("up")):
		jump()
		
	if (event.is_action_released("crouch")):
		run()

func jump():
	character.velocity.y = jump_velocity
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = air_state
	playback.travel(jump_animation)
	
func run():
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = run_state
	playback.travel(run_animation)
