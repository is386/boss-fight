class_name State
extends Node

@export var player: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func play_entry_animation() -> void:
	pass
