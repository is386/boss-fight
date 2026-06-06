class_name BossHealthComponent
extends HealthComponent

@export var num_stuns: int
@export var phase_two_health_ratio: float 

var health_at_last_stun: int
var stun_health_increment: int

signal is_stunned

func _ready() -> void:
	super._ready()
	health_at_last_stun = max_health
	stun_health_increment = max_health / (num_stuns + 1)

func subtract_health(amount: int) -> void:
	super.subtract_health(amount)

	if health_at_last_stun - current_health >= stun_health_increment:
		health_at_last_stun = current_health
		is_stunned.emit()	

