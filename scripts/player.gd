extends Node3D

class_name Player

signal fireLaser(muzzlePosition)

@onready var center_muzzle = $CenterMuzzle

@export var SPEED = 20
@export var health_component: HealthComponent

var movement_clamp_vertical = 15
var movement_clamp_horizontal = movement_clamp_vertical * (16.0/9.0) #Aspect Ratio

func _physics_process(delta):

	var direction:= Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		rotation.z = lerp_angle(rotation.z, deg_to_rad(-30), 0.5)
		direction.y = 1
	elif Input.is_action_pressed("move_down"):
		rotation.z = lerp_angle(rotation.z, deg_to_rad(30), 0.5)
		direction.y = -1
	else:
		rotation.z = lerp_angle(rotation.z, deg_to_rad(0), 0.5)
		
	if Input.is_action_pressed("move_left"):
		direction.x = 1
	elif Input.is_action_pressed("move_right"):
		direction.x = -1
	
	direction = direction.normalized()
	
	position.x = clamp(position.x + direction.x * SPEED * delta, -movement_clamp_horizontal, movement_clamp_horizontal)
	position.y = clamp(position.y + direction. y * SPEED * delta, -movement_clamp_vertical, movement_clamp_vertical)
	
func _input(event):
	if event.is_action_pressed("fire"):
		fireLaser.emit(center_muzzle.global_position)
