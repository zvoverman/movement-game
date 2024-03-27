extends Node

class_name State

@export var can_move : bool = true
@export var speed : float = 200.0
@export var jump_velocity : float = -400.0
@export var acceleration : float = 0.8

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass
	
func on_enter():
	pass
	
func on_exit():
	pass
