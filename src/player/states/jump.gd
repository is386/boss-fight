class_name PlayerJump
extends State

@export var player: Player
@export var jump_speed: float
@export var fall_state: State

func enter() -> void:
	player.sprite.play("jump")
	player.velocity.y = -jump_speed

func process_physics(delta: float) -> State:
	if player.velocity.y >= 0:
		return fall_state

	player.velocity_component.apply_gravity(delta)
	player.velocity_component.apply_horizontal_velocity(player.move_speed)
	player.move_and_slide()

	return null
		
