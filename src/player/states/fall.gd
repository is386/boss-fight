class_name PlayerFall
extends State

@export var idle_state: State
@export var jump_state: State
@export var crouch_state: State
@export var dash_state: State

var is_jump_buffered: bool = false

func enter() -> void:
	play_entry_animation()

func process_physics(delta: float) -> State:
	player.sprite.flip_h = player.direction != 1

	if player.movement_component.can_buffer_jump():
		is_jump_buffered = true

	if player.is_on_floor():
		player.dashed = false
		if is_jump_buffered:
			is_jump_buffered = false
			return jump_state
		return idle_state

	if player.movement_component.can_crouch():
		return crouch_state
	if player.movement_component.can_dash():
		return dash_state

	player.velocity_component.apply_gravity(delta)
	player.velocity_component.apply_horizontal_velocity(player.run_speed)
	player.move_and_slide()

	return null
	
func play_entry_animation() -> void:
	player.play_animation("fall")	
