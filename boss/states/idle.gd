class_name BossIdle
extends State

@export var run_state: State
@export var attack_state: State
@export var blast_charge_state: State
@export var jump_state: State

var boss: Boss
var isInCooldown: bool
var canJump: bool = true
var randVal: float = 1

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation("idle")	
	boss.velocity.x = 0

func process(_delta: float) -> State:
	if isInCooldown:
		return null	

	boss.sprite.flip_h = boss.input_component.get_run_direction() == -1

	if canJump:
		canJump = false
		return jump_state

	if randVal < 0.5:
		isInCooldown = true
		return blast_charge_state

	if !boss.isPlayerInRange:
		return run_state
	
	isInCooldown = true
	return attack_state


func player_detection_area_exited(_body: Node2D) -> void:
	boss.isPlayerInRange = false

func _on_cooldown_timer_timeout() -> void:
	isInCooldown = false
	canJump = true
	randVal = randf()

