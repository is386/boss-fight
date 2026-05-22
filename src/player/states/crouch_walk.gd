class_name PlayerCrouchWalk
extends State

@export var player: Player
@export var idle_state: State
@export var move_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var dash_state: State

func enter() -> void:
	player.sprite.play("crouch_walk")	

func process_physics(_delta: float) -> State:
	player.sprite.flip_h = player.direction != 1

	if player.movement_component.can_jump():
		return jump_state
	if !player.is_on_floor():
		return fall_state
	if player.movement_component.can_dash():
		return dash_state

	var isMoving = player.velocity_component.apply_horizontal_velocity(player.crouch_walk_speed)
	var isCrouching = player.movement_component.is_crouching()

	if !isCrouching and isMoving:
		return move_state
	if isCrouching and !isMoving:
		return crouch_state
	if !isCrouching and !isMoving:
		player.was_crouching = true
		return idle_state

	player.move_and_slide()

	return null
