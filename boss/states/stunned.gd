class_name BossStunned
extends BossState

@export var idle_state: State
@export var stunned_time: float
@export var body_hitbox: HitboxComponent
@export var stunned_hurtbox_component: HurtboxComponent
@export var audio_player: AudioStreamPlayer2D

func enter() -> void:
	boss.play_animation('stunned')	
	body_hitbox.disable()
	boss.hurtbox_component.disable()
	stunned_hurtbox_component.enable()
	stunned_hurtbox_component.scale.x = -boss.direction
	isStunned = true
	boss.velocity.x = 0
	audio_player.play()

	Engine.time_scale = 0 
	await get_tree().create_timer(0.2, true, false, true).timeout
	Engine.time_scale = 1.0

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
	boss.hurtbox_component.enable()
	stunned_hurtbox_component.disable()

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
	
