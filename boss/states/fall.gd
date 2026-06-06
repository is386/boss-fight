class_name BossFall
extends BossState

@export var idle_state: State

func enter() -> void:
	super.enter()
	boss.play_animation("fall")	

func process_physics(delta: float) -> State:
	if boss.is_on_floor():
		return idle_state

	boss.velocity_component.apply_gravity(delta)
	boss.velocity_component.apply_horizontal_velocity_direction(boss.run_speed, boss.direction)
	boss.move_and_slide()

	return null
	
