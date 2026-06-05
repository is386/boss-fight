class_name BossRunState
extends State

@export var idle_state: State

var boss: Boss

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation('run')

func process_physics(_delta: float) -> State:
	if boss.isPlayerInRange:
		return idle_state
	
	boss.velocity_component.apply_horizontal_velocity(boss.run_speed)
	boss.sprite.flip_h = boss.input_component.get_run_direction() == -1
	boss.move_and_slide()

	return null

func _on_player_detection_area_entered(_body: Node2D) -> void:
	boss.isPlayerInRange = true
