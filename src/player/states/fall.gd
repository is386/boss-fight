class_name PlayerFall
extends State

@export var player: Player
@export var idle_state: State
@export var crouch_state: State

func enter() -> void:
	player.sprite.play("fall")

func process_physics(delta: float) -> State:
	if player.is_on_floor():
		return idle_state
	if player.movement_component.can_crouch():
		return crouch_state

	player.velocity_component.apply_gravity(delta)
	player.velocity_component.apply_horizontal_velocity(player.move_speed)
	player.move_and_slide()

	return null
	
