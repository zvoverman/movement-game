extends State

class_name EnemyPatrolState

@export var patrol_width : float

var start_position_x : float
var direction : float
var turning : bool

func on_enter():
	print("enter")
	start_position_x = character.position.x
	direction = -1
	turning = false
	
func state_process(delta):
	if (!turning and abs(character.position.x - start_position_x) > patrol_width):
		direction = -direction
		turning = true
		
	if (abs(character.velocity.x) < speed):
		turning = false
		
	character.velocity.x = lerp(character.velocity.x, direction * speed, acceleration)
	print(character.velocity.x)
	
