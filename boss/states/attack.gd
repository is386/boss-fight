class_name BossAttackState
extends State

@export var idle_state: State
@export var cooldown_timer: Timer
@export var right_hitbox: CollisionShape2D
@export var left_hitbox: CollisionShape2D

var boss: Boss
var hitbox: CollisionShape2D

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation('attack')
	if boss.input_component.get_run_direction() == 1:
		hitbox = right_hitbox
	else:
		hitbox = left_hitbox

func exit() -> void:
	hitbox.disabled = true

func process(_delta: float) -> State:
	if boss.sprite.frame == 1:
		hitbox.disabled = false
	if !boss.sprite.is_playing():
		cooldown_timer.start()
		return idle_state
	return null	
