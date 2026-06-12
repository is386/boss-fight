class_name BossGroundSlamState
extends BossState

@export var idle_state: State
@export var body_hitbox: HitboxComponent
@export var ground_slam_hitbox: HitboxComponent
@export var sprite: Sprite2D
@export var delay: float

var is_following_player: bool = false 
var is_attacking: bool = false
var attack_count: int = 0
var camera: ShakingCamera

func _ready() -> void:
	super._ready()
	camera = get_tree().get_first_node_in_group("Camera")

func enter() -> void:
	boss.play_animation("vanish")
	boss.hurtbox_component.disable()
	body_hitbox.disable()

	var delay_timer = Timer.new()
	delay_timer.wait_time = delay 
	delay_timer.one_shot = true
	delay_timer.timeout.connect(_on_delay_timer_timeout)
	add_child(delay_timer)
	delay_timer.start()

func exit() -> void:
	is_attacking = false
	boss.hurtbox_component.enable()
	body_hitbox.enable()

func process(_delta: float) -> State:
	if !boss.sprite.is_playing() and !is_following_player and !is_attacking:
		sprite.visible = true
		is_following_player = true
		boss.global_position.y = boss.starting_position.y 

	if !boss.sprite.is_playing() and is_attacking:
		attack_count += 1
		if attack_count > 2:
			attack_count = 0
			return idle_state
		return self

	if boss.sprite.animation == "ground_slam" and boss.sprite.frame == 4:
		ground_slam_hitbox.enable()
		camera.screen_shake(2, 5)

	if boss.sprite.animation == "ground_slam" and boss.sprite.frame == 8:
		ground_slam_hitbox.disable()

	if is_following_player:	
		boss.global_position.x = boss.player.global_position.x

	return null

func _on_delay_timer_timeout() -> void:
	boss.play_animation("ground_slam")	
	sprite.visible = false
	is_following_player = false
	is_attacking = true	
