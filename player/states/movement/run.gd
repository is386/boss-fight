class_name PlayerRun
extends PlayerMoveState

@export var idle_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var dash_state: State
@export var sprint_jump_state: State

func enter() -> void:
	super.enter()
	play_entry_animation()

func exit() -> void:
	super.exit()
	player.play_effect("idle")

func process_physics(_delta: float) -> State:
	if player.input_component.can_sprint_jump():
		return sprint_jump_state
	if player.input_component.can_jump():
		return jump_state
	if !player.is_on_floor():
		return fall_state
	if player.input_component.can_crouch():
		return crouch_state
	if player.input_component.can_dash():
		return dash_state

	var prev_direction = player.direction

	if !player.velocity_component.apply_horizontal_velocity(_get_speed()):
		return idle_state

	if prev_direction != player.direction:
		player.sprite.flip_h = player.direction != 1
		player.effect_sprite.flip_h = player.direction != 1
		play_effect()

	player.move_and_slide()
	return null

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_released("dash"):
		play_entry_animation()
	return null

func _get_speed() -> float:
	if player.input_component.can_sprint():
		play_entry_animation()
		return player.sprint_speed
	return player.run_speed

func play_entry_animation() -> void:
	if player.input_component.can_sprint():
		player.play_animation("sprint")	
	else:
		player.play_animation("run")
	play_effect()

func play_effect() -> void:
	if player.direction == 1:
		player.play_effect("run_back")
	else:
		player.play_effect("run_front")

