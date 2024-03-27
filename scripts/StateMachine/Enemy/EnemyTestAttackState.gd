extends State

class_name EnemyTestAttackState

@export var agro_state : State

@export var attack_area : Area2D

func state_process(delta):
	var overlapping_bodies = attack_area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if (body.name == "Player"):
			attack()
			next_state = agro_state
	
func attack():
	await get_tree().create_timer(0.5).timeout
	var overlapping_bodies = attack_area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if (body.name == "Player"):
			body.health -= 1
