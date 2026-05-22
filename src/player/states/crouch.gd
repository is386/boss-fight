class_name PlayerCrouch
extends State

@export var player: Player
@export var idle_state: State
@export var jump_state: State
@export var crouch_walk_state: State
@export var dash_state: State

func enter() -> void:
	player.sprite.play("crouch")

func process_physics(_delta: float) -> State:
	if player.movement_component.can_jump():
		return jump_state
	if abs(player.movement_component.get_direction()) > 0:
		return crouch_walk_state 
	if player.movement_component.can_dash():
		return dash_state
	return null

func process_input(_event: InputEvent) -> State:
	if !player.movement_component.is_crouching():
		player.was_crouching = true
		return idle_state
	return null
