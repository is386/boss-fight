class_name BossInputComponent 
extends InputComponent

@export var boss: Boss

func get_run_direction() -> float:
	var direction = sign(boss.global_position.direction_to(boss.player.global_position).x)
	if direction == 0:
		return boss.direction
	boss.direction = direction
	return direction


