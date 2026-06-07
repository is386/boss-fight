class_name BossRunState
extends BossState

@export var idle_state: State

func enter() -> void:
	super.enter()
	boss.play_animation('run')
	play_effect()

func exit() -> void:
	super.exit()
	boss.play_effect("idle")

func process_physics(_delta: float) -> State:
	if boss.isPlayerInRange:
		return idle_state

	var prev_direction = boss.direction

	boss.velocity_component.apply_horizontal_velocity(boss.run_speed)

	if prev_direction != boss.direction:
		boss.sprite.flip_h = boss.direction != 1
		boss.effect_sprite.flip_h = boss.sprite.flip_h		
		play_effect()

	boss.move_and_slide()

	return null

func _on_player_detection_area_entered(_body: Node2D) -> void:
	boss.isPlayerInRange = true

func play_effect() -> void:
	if boss.direction != 1:
		boss.play_effect("run_back")
	else:
		boss.play_effect("run_front")
