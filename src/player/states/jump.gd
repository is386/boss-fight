class_name PlayerJump
extends State

@export var player: Player
@export var jump_speed: float
@export var fall_state: State
@export var dash_state: State

func enter() -> void:
	player.sprite.play("jump")
	player.velocity.y = -jump_speed

func process_physics(delta: float) -> State:
	player.sprite.flip_h = player.direction != 1

	if player.velocity.y >= 0:
		return fall_state
	if player.movement_component.can_dash():
		return dash_state

	player.velocity_component.apply_gravity(delta)
	player.velocity_component.apply_horizontal_velocity(player.move_speed)
	player.move_and_slide()

	return null
		
