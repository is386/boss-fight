class_name PlayerIdleAttack
extends State

@export var standing_attack_state: State
@export var running_attack_state: State

func enter() -> void:
	player.movement_state_machine.current_state.play_entry_animation()

func process_input(_event: InputEvent) -> State:
	if player.movement_component.can_attack():
		if player.movement_component.can_run():
			return running_attack_state 
		return standing_attack_state
	return null
	
