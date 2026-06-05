class_name PlayerCrouch
extends PlayerMoveState

@export var idle_state: State
@export var jump_state: State
@export var crouch_walk_state: State
@export var dash_state: State

func enter() -> void:
	super.enter()
	play_entry_animation()

func process_physics(_delta: float) -> State:
	if player.input_component.can_jump():
		return jump_state
	if player.input_component.can_crouch_walk():
		return crouch_walk_state 
	if player.input_component.can_dash():
		return dash_state
	return null

func process_input(_event: InputEvent) -> State:
	if !player.input_component.is_crouching():
		player.was_crouching = true
		return idle_state
	return null

func play_entry_animation() -> void:
	player.play_animation("crouch")	
