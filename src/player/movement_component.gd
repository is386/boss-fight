class_name MovementComponent
extends Node

@export var player: Player

func get_direction() -> float:
	return Input.get_axis("move_left", "move_right")

func can_jump() -> bool:
	return Input.is_action_just_pressed("jump") and player.is_on_floor()

func can_crouch() -> bool:
	return is_crouching() and player.is_on_floor()

func can_roll() -> bool:
	return Input.is_action_just_pressed("roll") and player.is_on_floor()

func can_dash() -> bool:
	return Input.is_action_just_pressed("dash") and !player.dashed

func is_crouching() -> bool:
	return Input.is_action_pressed("crouch")

func can_sprint() -> bool:
	return Input.is_action_pressed("dash") and !player.dashed
