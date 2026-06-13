class_name BossAppear
extends BossState

@export var idle_state: State
@export var body_hitbox: HitboxComponent 
@export var hurtbox: HurtboxComponent
@export var audio_player: AudioStreamPlayer2D

func enter() -> void:
	super.enter()
	boss.play_animation("appear")	
	audio_player.play()

func exit() -> void:
	super.exit()
	body_hitbox.enable()
	hurtbox.enable()

func process(delta: float) -> State:
	var state = super.process(delta)
	if state:
		return state

	if !boss.sprite.is_playing():	
		return idle_state
	return null
