extends State

class_name EnemyTestIdleState

@export var patrol_state : State
@export var agro_state : State

func state_process(delta):	
	character.velocity.x = lerp(character.velocity.x, 0.0, 0.2)
	
func patrol():
	next_state = patrol_state

func _on_agro_area_body_entered(body):
	if (body.name == "Player"):
		next_state = agro_state
