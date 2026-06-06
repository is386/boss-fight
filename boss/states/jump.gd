class_name BossJump
extends BossState

@export var fall_state: State

func enter() -> void:
	super.enter()
	boss.play_animation('jump')
	boss.velocity.y = -boss.jump_speed
	boss.direction = boss.input_component.get_run_direction()

func process_physics(delta: float) -> State:
	if boss.velocity.y >= 0:
		return fall_state

	boss.velocity_component.apply_gravity(delta)
	boss.velocity_component.apply_horizontal_velocity_direction(boss.run_speed, boss.direction)
	boss.move_and_slide()

	return null

