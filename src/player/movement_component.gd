class_name MovementComponent
extends Node

@export var player: Player

func can_move() -> bool:
	return player.enable_move and abs(player.movement_component.get_direction()) > 0

func get_direction() -> float:
	if !player.enable_move:
		return 0
	return Input.get_axis("move_left", "move_right")

func can_jump() -> bool:
	return player.enable_jump and Input.is_action_just_pressed("jump") and player.is_on_floor()

func can_buffer_jump() -> bool:
	return player.enable_jump and Input.is_action_just_pressed("jump")

func can_crouch() -> bool:
	return player.enable_crouch and is_crouching() and player.is_on_floor()

func can_crouch_walk() -> bool:
	return player.enable_crouch_walk and is_crouching() and can_move()

func is_crouching() -> bool:
	return player.enable_crouch and Input.is_action_pressed("crouch")

func can_dash() -> bool:
	return player.enable_dash and Input.is_action_just_pressed("dash") and !player.dashed

func can_sprint() -> bool:
	return player.enable_sprint and Input.is_action_pressed("dash") 

func can_sprint_jump() -> bool:
	return player.enable_sprint_jump and can_jump() and can_sprint()
