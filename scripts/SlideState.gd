extends State

class_name SlideState

@export var idle_state : State
@export var air_state : State
@export var crouch_state : State
@export var walk_state : State
@export var run_state : State

@export var original_collision : CollisionShape2D
@export var crouch_collision : CollisionShape2D
@export var idle_animation : String
@export var run_animation : String
@export var walk_animation : String
@export var crouch_animation : String
@export var jump_animation : String

func on_enter():
	character.velocity.x *= 1.1
	original_collision.disabled = true
	crouch_collision.disabled = false

func state_process(delta):
	character.velocity.x = lerp(character.velocity.x, 0.0, 0.01)
	
	if (abs(character.velocity.x) <= crouch_state.speed):
		crouch()
	if (Input.is_action_just_released("crouch")):
		if (not Input.is_action_pressed("left") and not Input.is_action_pressed("right")):
			idle()
		if (abs(character.velocity.x) > walk_state.speed):
			run()
		else:
			walk()
	
func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	
func idle():
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = idle_state
	playback.travel(idle_animation)
	
func jump():
	original_collision.disabled = false
	crouch_collision.disabled = true
	character.velocity.y = jump_velocity
	#character.velocity.x *= 1.2
	next_state = air_state
	playback.travel(jump_animation)
	
func crouch():
	next_state = crouch_state
	playback.travel(crouch_animation)
	
func walk():
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = walk_state
	playback.travel(walk_animation)
	
func run():
	original_collision.disabled = false
	crouch_collision.disabled = true
	next_state = run_state
	playback.travel(run_animation)
