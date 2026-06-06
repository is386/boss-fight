class_name BossHealthComponent
extends HealthComponent

@export var num_stuns: int
@export var phase_two_health_ratio: float 

var health_at_last_stun: int
var stun_health_increment: int
var boss: Boss

signal is_stunned
signal is_phase_two

func _ready() -> void:
	super._ready()
	boss = owner as Boss
	health_at_last_stun = max_health
	stun_health_increment = max_health / (num_stuns + 1)

func subtract_health(amount: int) -> void:
	super.subtract_health(amount)

	if health_at_last_stun - current_health >= stun_health_increment:
		health_at_last_stun = current_health
		is_stunned.emit()	
		return

	if !boss.is_phase_two and phase_two_health_ratio * max_health >= current_health:
		is_phase_two.emit()
