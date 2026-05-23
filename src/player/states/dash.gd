class_name PlayerDash
extends State

@export var player: Player
@export var idle_state: State
@export var run_state: State
@export var fall_state: State
@export var crouch_state: State
@export var crouch_walk_state: State

var start: Vector2

func enter() -> void:
	player.sprite.play("dash")
	player.dashed = true
	player.velocity.x = player.dash_speed 
	player.velocity.y = 0

	start = player.global_position

	if player.sprite.flip_h:
		player.velocity.x *= -1

func process_physics(delta: float) -> State:
	player.sprite.flip_h = player.direction != 1
	player.velocity_component.apply_gravity(delta*0.5)

	var distance = player.global_position.distance_to(start)
	if distance >= player.dash_distance:
		if !player.is_on_floor():
			return fall_state

		player.dashed = false

		var isMoving = player.velocity_component.apply_horizontal_velocity(player.crouch_walk_speed)
		var isCrouching = player.movement_component.is_crouching()
		player.sprite.flip_h = player.direction != 1

		if isCrouching and isMoving:
			return crouch_walk_state
		if !isCrouching and isMoving:
			return run_state
		if isCrouching and !isMoving:
			return crouch_state
		if !isCrouching and !isMoving:
			return idle_state

	player.move_and_slide()
	return null
