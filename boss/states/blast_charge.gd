class_name BossBlastCharge
extends BossState

@export var blast_attack_state: State
@export var charge_time: float = 2.0
@export var audio_player: AudioStreamPlayer2D

var isCharged: bool = false

func enter() -> void:
	super.enter()
	isCharged = false
	boss.play_animation("blast_charge")
	audio_player.play()
	await get_tree().create_timer(charge_time).timeout 
	isCharged = true

func process(delta: float) -> State:
	var state = super.process(delta)
	if state:
		return state

	boss.sprite.flip_h = boss.input_component.get_run_direction() == -1

	if isCharged:
		return blast_attack_state

	return null
