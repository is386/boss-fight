class_name BossAttackState
extends State

@export var idle_state: State
@export var cooldown_timer: Timer
@export var right_hitbox: HitboxComponent 
@export var left_hitbox: HitboxComponent

var boss: Boss
var hitbox: HitboxComponent

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation('attack')
	if boss.input_component.get_run_direction() == 1:
		hitbox = right_hitbox
	else:
		hitbox = left_hitbox

func exit() -> void:
	hitbox.disable()

func process(_delta: float) -> State:
	if boss.sprite.frame == 1:
		hitbox.enable()
	if boss.sprite.frame == 3:
		hitbox.disable()
	if !boss.sprite.is_playing():
		cooldown_timer.start()
		return idle_state
	return null	
