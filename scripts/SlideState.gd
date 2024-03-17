extends State

class_name SlideState

@export var idle_state : State
@export var air_state : State
@export var crouch_state : State
@export var run_state : State

@export var original_collision : CollisionShape2D
@export var crouch_collision : CollisionShape2D
@export var idle_animation : String
@export var run_animation : String
@export var crouch_animation : String
@export var jump_animation : String

func on_enter():
	character.velocity.x *= 1.2
	original_collision.disabled = true
	crouch_collision.disabled = false

func state_process(delta):
	#character.velocity.x = lerp(character.velocity.x, 0.0, 0.1)
	if (abs(character.velocity.x) < 200):
		run()
	
func state_input(event : InputEvent):
	if (event.is_action_pressed("jump") or event.is_action_pressed("up")):
		jump()
	
func jump():
	original_collision.disabled = false
	crouch_collision.disabled = true
	character.velocity.y = jump_velocity
	character.velocity.x *= 1.2
	next_state = air_state
	playback.travel(jump_animation)
	
func crouch():
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = crouch_state
	playback.travel(crouch_animation)
	
func run():
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = run_state
	playback.travel(run_animation)
