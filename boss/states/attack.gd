class_name BossAttackState
extends BossState

@export var idle_state: State
@export var cooldown_timer: Timer
@export var right_hitbox: HitboxComponent 
@export var left_hitbox: HitboxComponent
@export var audio_player: AudioStreamPlayer2D

var hitbox: HitboxComponent

func enter() -> void:
	super.enter()
	audio_player.play()
	boss.play_animation('attack')
	if boss.input_component.get_run_direction() == 1:
		hitbox = right_hitbox
	else:
		hitbox = left_hitbox

func exit() -> void:
	super.exit()
	hitbox.disable()

func process(delta: float) -> State:
	var state = super.process(delta)
	if state:
		return state

	if boss.sprite.frame == 1:
		hitbox.enable()
	if boss.sprite.frame == 3:
		hitbox.disable()
	if !boss.sprite.is_playing():
		cooldown_timer.start()
		return idle_state
	return null	
