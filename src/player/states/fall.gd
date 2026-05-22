class_name PlayerFall
extends State

@export var player: Player
@export var idle_state: State
@export var crouch_state: State
@export var dash_state: State

func enter() -> void:
	player.sprite.play("fall")

func process_physics(delta: float) -> State:
	player.sprite.flip_h = player.direction != 1

	if player.is_on_floor():
		player.dashed = false
		return idle_state
	if player.movement_component.can_crouch():
		return crouch_state
	if player.movement_component.can_dash():
		return dash_state

	player.velocity_component.apply_gravity(delta)
	player.velocity_component.apply_horizontal_velocity(player.move_speed)
	player.move_and_slide()

	return null
	
