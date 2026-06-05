class_name BossInputComponent 
extends InputComponent

@export var boss: Boss

func get_run_direction() -> float:
	return sign(boss.global_position.direction_to(boss.player.global_position).x)

