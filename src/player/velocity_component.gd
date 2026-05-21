class_name VelocityComponent
extends Node

@export var player: Player

func apply_horizontal_velocity(speed: float) -> bool:
	var direction := player.movement_component.get_direction()
	if direction:
		player.velocity.x = direction * speed 
		player.sprite.flip_h = direction != 1
	else:
		player.velocity.x = 0 
		return false
	return true

func apply_gravity(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
