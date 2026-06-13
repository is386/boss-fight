class_name BossPowerUp
extends BossState

@export var idle_state: State
@export var audio_player: AudioStreamPlayer2D

var camera: ShakingCamera

func _ready() -> void:
	super._ready()
	camera = get_tree().get_first_node_in_group("Camera")

func enter() -> void:
	boss.play_animation("power_up")
	boss.hurtbox_component.disable()
	audio_player.play()

	var power_up_timer = Timer.new()
	power_up_timer.wait_time = 3
	power_up_timer.one_shot = true
	power_up_timer.timeout.connect(_on_power_up_timer_timeout)
	add_child(power_up_timer)
	power_up_timer.start()

	camera.screen_shake(2, 3.25)

func exit() -> void:
	boss.num_attacks = 2
	boss.canJump = true
	boss.isInCooldown = false
	boss.hurtbox_component.enable()

func process(_delta: float) -> State:
	if boss.is_phase_two:
		return idle_state
	return null

func _on_power_up_timer_timeout() -> void:
	boss.is_phase_two = true		
