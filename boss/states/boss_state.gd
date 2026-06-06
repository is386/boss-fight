class_name BossState
extends State

@export var stun_state: State

var boss: Boss
var boss_health_component: BossHealthComponent
var isStunned: bool = false

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss_health_component =	boss.hurtbox_component.health_component as BossHealthComponent
	boss_health_component.is_stunned.connect(_on_stunned)

func exit() -> void:
	if boss_health_component.is_stunned.is_connected(_on_stunned):
		boss_health_component.is_stunned.disconnect(_on_stunned)

func process(_delta: float) -> State:
	if isStunned:
		isStunned = false
		return stun_state 
	return null

func _on_stunned() -> void:
	isStunned = true

