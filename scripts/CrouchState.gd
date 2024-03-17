extends State

class_name CrouchState

@export var idle_state : State
@export var air_state : State

@export var original_collision : CollisionShape2D
@export var crouch_collision : CollisionShape2D
@export var idle_animation : String
@export var jump_animation : String

func on_enter():
	original_collision.disabled = true
	crouch_collision.disabled = false

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
		
	if (event.is_action_released("crouch")):
		idle()

func jump():
	character.velocity.y = jump_velocity
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = air_state
	playback.travel(jump_animation)
	
func idle():
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = idle_state
	playback.travel(idle_animation)
