extends CharacterBody2D

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var initial_position = position

@export var max_health : int = 1
var health : int

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	health = max_health
	
func _physics_process(delta):
	
	if (health == 0):
		die()
		
	velocity.y += gravity * delta

	move_and_slide()
	
func die():
	hide()
	set_process_mode(PROCESS_MODE_DISABLED) 
	set_physics_process(PROCESS_MODE_DISABLED)
	
func reset():
	global_position = initial_position
	health = max_health
	set_process_mode(PROCESS_MODE_ALWAYS) 
	set_physics_process(PROCESS_MODE_ALWAYS)
	show()
