extends RigidBody2D

class_name PlayerSword

var speed : float = 700.0

#func _physics_process(delta):
	#position += velocity * delta


func _on_body_entered(body):
	if (body.is_in_group("enemies")):
		body.health -= 1
