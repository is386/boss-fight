class_name BossFall
extends BossState

@export var idle_state: State
@export var falling_effect_scene: PackedScene

func enter() -> void:
	super.enter()
	boss.play_animation("fall")	

func process_physics(delta: float) -> State:
	if boss.is_on_floor():
		var falling_effect = falling_effect_scene.instantiate() as SpawnableEffect
		falling_effect.global_position = boss.global_position 
		add_child(falling_effect)
		return idle_state

	boss.velocity_component.apply_gravity(delta)
	boss.velocity_component.apply_horizontal_velocity_direction(boss.run_speed, boss.direction)
	boss.move_and_slide()

	return null
	
