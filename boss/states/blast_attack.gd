class_name BossBlastAttack
extends BossState

@export var idle_state: State
@export var cooldown_timer: Timer
@export var laser_scene: PackedScene
@export var audio_player: AudioStreamPlayer2D

var camera: ShakingCamera

func _ready() -> void:
	super._ready()
	camera = get_tree().get_first_node_in_group("Camera")

func enter() -> void:
	super.enter()
	boss.play_animation('blast_attack')
	var laser = laser_scene.instantiate() as Laser
	laser.scale.x = sign(boss.direction)
	laser.global_position = boss.global_position
	laser.global_position.x += 55 * sign(boss.direction)
	laser.global_position.y += -2 
	camera.screen_shake(2, 0.5)
	audio_player.play()
	add_child(laser)

func process(delta: float) -> State:
	var state = super.process(delta)
	if state:
		return state

	if !boss.sprite.is_playing():
		cooldown_timer.start()
		return idle_state
	return null	
