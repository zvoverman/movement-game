extends CharacterBody2D

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var left = false
var right = false

func _physics_process(delta):
	velocity.y += gravity * delta
	var speed = state_machine.current_state.speed
	var acceleration = state_machine.current_state.acceleration
	
	if (state_machine.check_if_can_move()):
		var direction = Input.get_axis("left", "right")
		if direction == -1:
			$Sprite2D.flip_h = true
			velocity.x = lerp(velocity.x, direction * speed, acceleration)
		elif direction == 1:
			$Sprite2D.flip_h = false
			velocity.x = lerp(velocity.x, direction * speed, acceleration)
		elif left:
			$Sprite2D.flip_h = true
			velocity.x = lerp(velocity.x, -1 * speed, acceleration)
		elif right:
			$Sprite2D.flip_h = false
			velocity.x = lerp(velocity.x, 1 * speed, acceleration)
		
	if (velocity.x >= 400):
		velocity.x = 400
	elif (velocity.x <= -400):
		velocity.x = -400
	
	move_and_slide()
	
func _input(event : InputEvent):
	if (event.is_action_pressed("left")):
		left = true
		right = false
	
	if (event.is_action_released("left")):
		left = false
	
	if (event.is_action_pressed("right")):
		right = true
		left = false
		
	if (event.is_action_released("right")):
		right = false
