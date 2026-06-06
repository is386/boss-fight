class_name BossStunned
extends BossState

@export var idle_state: State
@export var stunned_time: float
@export var body_hitbox: HitboxComponent

func enter() -> void:
	boss.play_animation('stunned')	
	body_hitbox.disable()
	isStunned = true

	var stunned_timer = Timer.new()
	stunned_timer.wait_time = stunned_time
	stunned_timer.one_shot = true
	stunned_timer.timeout.connect(_on_stunned_timer_timeout)
	add_child(stunned_timer)
	stunned_timer.start()

func exit() -> void:
	boss.canJump = true
	boss.isInCooldown = false
	body_hitbox.enable()

func process(_delta: float) -> State:
	if !isStunned:
		return idle_state
	return null

func process_physics(delta: float) -> State:
	boss.velocity_component.apply_gravity(delta)
	boss.move_and_slide()
	return null

func _on_stunned_timer_timeout() -> void:
	isStunned = false	
	
