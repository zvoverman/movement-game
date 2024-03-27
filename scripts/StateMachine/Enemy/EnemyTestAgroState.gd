extends State

class_name EnemyTestAgroState

@export var idle_state : State
@export var attack_state : State

@export var agro_area : Area2D
@export var attack_area : Area2D

func state_process(delta):
	var overlapping_bodies = agro_area.get_overlapping_bodies()
	var vector_dist = 0.0
	for body in overlapping_bodies:
		if (body.name == "Player"):
			vector_dist = body.position.x - character.position.x
	character.velocity.x = lerp(character.velocity.x, vector_dist, 0.8)


func _on_agro_area_body_exited(body):
	if (body.name == "Player"):
		next_state = idle_state


func _on_attack_area_body_entered(body):
	if (body.name == "Player"):
		next_state = attack_state
