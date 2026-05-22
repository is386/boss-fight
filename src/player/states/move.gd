class_name PlayerMove
extends State

@export var player: Player
@export var idle_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var dash_state: State
@export var sprint_jump_state: State

var is_turning_around = false
var is_dash_buffered = false 

func enter() -> void:
	player.sprite.play("run")
	player.sprite.animation_finished.connect(_on_turn_around_animation_finished)

func exit() -> void:
	is_turning_around = false
	player.sprite.animation_finished.disconnect(_on_turn_around_animation_finished)	

func process_physics(_delta: float) -> State:
	if !is_turning_around and player.movement_component.can_jump() and player.movement_component.can_sprint():
		return sprint_jump_state
	if player.movement_component.can_jump():
		return jump_state
	if !player.is_on_floor():
		return fall_state
	if player.movement_component.can_crouch():
		return crouch_state

	if is_turning_around:
		if player.movement_component.can_dash():
			is_dash_buffered = true
		player.move_and_slide()
		return
	else:
		if is_dash_buffered:
			is_dash_buffered = false
			return dash_state

	if player.movement_component.can_dash():
		return dash_state

	var currentDirection = player.direction

	var speed = player.move_speed
	if player.movement_component.can_sprint():
		speed = player.sprint_speed
		player.sprite.play("sprint")

	var isMoving = player.velocity_component.apply_horizontal_velocity(speed)
	if !isMoving:
		return idle_state

	if currentDirection != player.direction:
		currentDirection = player.direction
		player.sprite.play("turn_around")
		is_turning_around = true
	
	player.move_and_slide()

	return null

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_released("dash"):
		player.sprite.play("run")
	return null

func _on_turn_around_animation_finished() -> void:
	player.sprite.flip_h = player.direction != 1
	player.sprite.play("run")
	is_turning_around = false

