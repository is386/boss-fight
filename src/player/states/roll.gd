class_name PlayerRoll
extends State

@export var player: Player
@export var idle_state: State
@export var move_state: State
@export var fall_state: State
@export var crouch_state: State
@export var crouch_walk_state: State

func enter() -> void:
	player.sprite.play("roll")
	player.velocity.x = player.roll_speed 
	if player.sprite.flip_h:
		player.velocity.x *= -1

func process_physics(_delta: float) -> State:
	if not player.sprite.is_playing():
		if !player.is_on_floor():
			return fall_state

		var isMoving = player.velocity_component.apply_horizontal_velocity(player.crouch_walk_speed)
		var isCrouching = player.movement_component.is_crouching()

		if isCrouching and isMoving:
			return crouch_walk_state
		if !isCrouching and isMoving:
			return move_state
		if isCrouching and !isMoving:
			return crouch_state
		if !isCrouching and !isMoving:
			return idle_state

	player.move_and_slide()
	return null

