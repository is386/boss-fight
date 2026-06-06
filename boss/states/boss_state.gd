class_name BossState
extends State

@export var stun_state: State
@export var power_up_state: State

var boss: Boss
var boss_health_component: BossHealthComponent
var isStunned: bool = false
var is_phase_two_just_activated = false

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss_health_component =	boss.hurtbox_component.health_component as BossHealthComponent
	boss_health_component.is_stunned.connect(_on_stunned)
	boss_health_component.is_phase_two.connect(_on_phase_two_activated)

func exit() -> void:
	if boss_health_component.is_stunned.is_connected(_on_stunned):
		boss_health_component.is_stunned.disconnect(_on_stunned)
	if boss_health_component.is_phase_two.is_connected(_on_phase_two_activated):
		boss_health_component.is_phase_two.disconnect(_on_phase_two_activated)

func process(_delta: float) -> State:
	if isStunned:
		isStunned = false
		return stun_state 
	
	if is_phase_two_just_activated:
		is_phase_two_just_activated = false
		return power_up_state

	return null

func _on_stunned() -> void:
	isStunned = true

func _on_phase_two_activated() -> void:
	is_phase_two_just_activated = true
