class_name BossPowerUp
extends BossState

@export var idle_state: State

func enter() -> void:
	boss.play_animation("power_up")
	boss.hurtbox_component.disable()

	var power_up_timer = Timer.new()
	power_up_timer.wait_time = 3
	power_up_timer.one_shot = true
	power_up_timer.timeout.connect(_on_power_up_timer_timeout)
	add_child(power_up_timer)
	power_up_timer.start()

func exit() -> void:
	boss.canJump = true
	boss.isInCooldown = false
	boss.hurtbox_component.enable()

func process(_delta: float) -> State:
	if boss.is_phase_two:
		return idle_state
	return null

func _on_power_up_timer_timeout() -> void:
	boss.is_phase_two = true		
