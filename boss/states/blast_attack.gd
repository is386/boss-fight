class_name BossBlastAttack
extends State

@export var idle_state: State
@export var cooldown_timer: Timer
@export var laser_scene: PackedScene

var boss: Boss

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation('blast_attack')
	var laser = laser_scene.instantiate() as Laser
	laser.scale.x = sign(boss.direction)
	laser.global_position = boss.global_position
	laser.global_position.x += 55 * sign(boss.direction)
	laser.global_position.y += -2 
	add_child(laser)

func process(_delta: float) -> State:
	if !boss.sprite.is_playing():
		cooldown_timer.start()
		return idle_state
	return null	
