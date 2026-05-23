class_name PlayerRun
extends State

@export var idle_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var dash_state: State
@export var sprint_jump_state: State

func enter() -> void:
	play_entry_animation()

func process_physics(_delta: float) -> State:
	if player.movement_component.can_sprint_jump():
		return sprint_jump_state
	if player.movement_component.can_jump():
		return jump_state
	if !player.is_on_floor():
		return fall_state
	if player.movement_component.can_crouch():
		return crouch_state
	if player.movement_component.can_dash():
		return dash_state
	var prev_direction = player.direction
	if !player.velocity_component.apply_horizontal_velocity(_get_speed()):
		return idle_state
	if prev_direction != player.direction:
		player.sprite.flip_h = player.direction != 1
	player.move_and_slide()
	return null

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_released("dash"):
		play_entry_animation()
	return null

func _get_speed() -> float:
	if player.movement_component.can_sprint():
		play_entry_animation()
		return player.sprint_speed
	return player.run_speed

func play_entry_animation() -> void:
	if player.movement_component.can_sprint():
		player.play_animation("sprint")	
	else:
		player.play_animation("run")
	
