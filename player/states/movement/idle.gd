class_name PlayerIdle
extends PlayerMoveState

@export var run_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var dash_state: State

func enter() -> void:
	super.enter()
	player.is_idle = true
	play_entry_animation()
	player.velocity.x = 0

func exit() -> void:
	super.exit()
	player.is_idle = false

func process_physics(_delta: float) -> State:
	if player.was_crouching:
		return
	if !player.is_on_floor():
		return fall_state
	if player.input_component.can_run():
		return run_state
	if player.input_component.can_jump():
		return jump_state
	if player.input_component.can_crouch():
		return crouch_state
	if player.input_component.can_dash():
		return dash_state
	return null

func _on_get_up_animation_finished() -> void:
	play_entry_animation()
	player.sprite.animation_finished.disconnect(_on_get_up_animation_finished)
	player.was_crouching = false

func play_entry_animation() -> void:
	player.play_animation("idle")	
	player.play_effect("idle")
