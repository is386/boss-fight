class_name PlayerIdle
extends State

@export var player: Player
@export var move_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var roll_state: State

func enter() -> void:
	player.sprite.play("idle")
	player.velocity.x = 0

func process_physics(_delta: float) -> State:
	if !player.is_on_floor():
		return fall_state
	if abs(player.movement_component.get_direction()) > 0:
		return move_state
	if player.movement_component.can_jump():
		return jump_state
	if player.movement_component.can_crouch():
		return crouch_state
	if player.movement_component.can_roll():
		return roll_state
	return null
