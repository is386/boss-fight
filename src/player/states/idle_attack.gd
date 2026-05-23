class_name PlayerIdleAttack
extends State

@export var standing_attack_state: State
@export var running_attack_state: State
@export var aerial_attack_state: State
@export var upwards_aerial_attack_state: State
@export var downwards_aerial_attack_state: State

func enter() -> void:
	player.movement_state_machine.current_state.play_entry_animation()

func process_input(_event: InputEvent) -> State:
	if player.movement_component.can_crouch():
		return

	if player.movement_component.can_attack():
		if player.movement_component.can_run():
			return running_attack_state 
		return standing_attack_state

	if player.movement_component.can_aerial_attack():
		if player.movement_component.is_holding_up():
			return upwards_aerial_attack_state
		if player.movement_component.is_holding_down():
			return downwards_aerial_attack_state 
		return aerial_attack_state

	return null
	
