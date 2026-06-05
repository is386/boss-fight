class_name VelocityComponent
extends Node

var entity: Entity

func _ready() -> void:
	entity = owner as Entity

func apply_horizontal_velocity(speed: float) -> bool:
	var direction := entity.input_component.get_run_direction()
	return apply_horizontal_velocity_direction(speed, direction)
	
func apply_horizontal_velocity_direction(speed: float, direction: float) -> bool:
	if !direction:
		entity.velocity.x = 0 
		return false

	entity.velocity.x = direction * speed 
	entity.direction = direction
	return true

func apply_gravity(delta: float) -> void:
	entity.velocity += entity.get_gravity() * delta
