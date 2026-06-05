class_name BossBlastCharge
extends State

@export var blast_attack_state: State
@export var charge_time: float = 2.0

var boss: Boss
var isCharged: bool = false

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	isCharged = false
	boss.play_animation("blast_charge")
	await get_tree().create_timer(charge_time).timeout 
	isCharged = true

func process(_delta: float) -> State:
	boss.sprite.flip_h = boss.input_component.get_run_direction() == -1

	if isCharged:
		return blast_attack_state

	return null
