class_name BossAttackState
extends State

@export var idle_state: State
@export var cooldown_timer: Timer

var boss: Boss

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation('attack')

func process(_delta: float) -> State:
	if !boss.sprite.is_playing():
		cooldown_timer.start()
		return idle_state
	return null	
