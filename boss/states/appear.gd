class_name BossAppear
extends State

@export var idle_state: State
@export var body_hitbox: HitboxComponent 
@export var hurtbox: HurtboxComponent

var boss: Boss

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation("appear")	

func exit() -> void:
	body_hitbox.enable()
	hurtbox.enable()

func process(_delta: float) -> State:
	if !boss.sprite.is_playing():	
		return idle_state
	return null
