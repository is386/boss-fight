class_name BossIdle
extends BossState

@export var run_state: State
@export var attack_state: State
@export var blast_charge_state: State
@export var jump_state: State

var randVal: float = 1
var num_attacks = 0

func enter() -> void:
	super.enter()
	boss.play_animation("idle")	
	boss.velocity.x = 0

func process(delta: float) -> State:
	var state = super.process(delta)
	if state:
		return state

	if boss.isInCooldown:
		return null	

	boss.sprite.flip_h = boss.input_component.get_run_direction() == -1

	if boss.is_phase_two and num_attacks == 2:
		print("PHASE TWO ATTACK")
		num_attacks = 0

	if boss.canJump:
		boss.canJump = false
		return jump_state

	if randVal < 0.5:
		boss.isInCooldown = true
		num_attacks += 1
		return blast_charge_state

	if !boss.isPlayerInRange:
		return run_state
	
	boss.isInCooldown = true
	num_attacks += 1
	return attack_state


func player_detection_area_exited(_body: Node2D) -> void:
	boss.isPlayerInRange = false

func _on_cooldown_timer_timeout() -> void:
	boss.isInCooldown = false
	boss.canJump = true
	randVal = randf()

