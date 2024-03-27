extends CharacterBody2D

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var sword_spawn : Marker2D = $SwordSpawn
@onready var initial_position = position
@onready var sword_pickup_area : Area2D = $SwordPickupArea

@export var max_health : int = 1
var health : int

@export var sword : PackedScene
var sword_instance : PlayerSword

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var left = false
var right = false
const MAX_VELOCITY = 400

func _ready():
	health = max_health

func _physics_process(delta):
	if (health == 0):
		die()
	move(delta)

func move(delta):
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
		elif is_on_floor():
			# Idle State stop
			velocity.x = lerp(velocity.x, 0.0, 0.2)
	
	# Cap velocity
	if (velocity.x >= MAX_VELOCITY):
		velocity.x = MAX_VELOCITY
	elif (velocity.x <= -MAX_VELOCITY):
		velocity.x = -MAX_VELOCITY
	
	move_and_slide()
	
func throw():
	if (get_tree().current_scene.get_node("PlayerSword")): 
		teleport_to_sword()
		return
		
	disable_pickup()
	sword_instance = sword.instantiate()
	owner.add_child(sword_instance)
	sword_instance.transform = sword_spawn.global_transform
	sword_instance.linear_velocity = global_position.direction_to(get_global_mouse_position()) * sword_instance.speed
	sword_instance.angular_velocity = 20.0

func die():
	hide()
	set_process_mode(PROCESS_MODE_DISABLED) 
	set_physics_process(PROCESS_MODE_DISABLED)
	await get_tree().create_timer(1.0).timeout
	
	reset()
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.reset()
	
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
		
	if (event.is_action_pressed("throw_sword")):
		throw()
		
func reset():
	owner.remove_child(sword_instance)
	global_position = initial_position
	health = max_health
	set_process_mode(PROCESS_MODE_ALWAYS) 
	set_physics_process(PROCESS_MODE_ALWAYS)
	show()
	
func teleport_to_sword():
	var new_pos = sword_instance.global_position
	new_pos.y += scale.y/2.0
	owner.remove_child(sword_instance)
	global_position = new_pos
	
	await get_tree().create_timer(0.1).timeout
	
	var overlapping_bodies = $TeleportDamageArea.get_overlapping_bodies()
	for body in overlapping_bodies:
		print(body)
		if (body.is_in_group("enemies")):
			body.health -= 1

func _on_sword_pickup_area_body_entered(body):
	if (body.name == "PlayerSword"):
		owner.remove_child(sword_instance)
		
func disable_pickup():
	remove_child(sword_pickup_area)
	await get_tree().create_timer(1.0).timeout
	add_child(sword_pickup_area)
	
