class_name InputComponent
extends Node

func can_run() -> bool:
	return false

func get_run_direction() -> float:
	return 0

func can_jump() -> bool:
	return false

func can_buffer_jump() -> bool:
	return false

func can_crouch() -> bool:
	return false

func can_crouch_walk() -> bool:
	return false

func is_crouching() -> bool:
	return false 

func can_dash() -> bool:
	return false

func can_sprint() -> bool:
	return false

func can_sprint_jump() -> bool:
	return false

func can_attack() -> bool:
	return false

func can_aerial_attack() -> bool:
	return false 

func is_holding_up() -> bool:
	return false 

func is_holding_down() -> bool:
	return false
