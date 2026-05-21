class_name PlayerMove
extends State

@export var player: Player
@export var idle_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var roll_state: State

func enter() -> void:
	player.sprite.play("run")

func process_physics(_delta: float) -> State:
	if player.movement_component.can_jump():
		return jump_state
	if !player.is_on_floor():
		return fall_state
	if !player.velocity_component.apply_horizontal_velocity(player.move_speed):
		return idle_state
	if player.movement_component.can_crouch():
		return crouch_state
	if player.movement_component.can_roll():
		return roll_state

	player.move_and_slide()

	return null
