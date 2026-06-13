class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent
@export var invulnerability_time: float
@export var sprite_flash: SpriteFlash
@export var enable_hitstop: bool = false
@export var enable_camera_shake: bool = false
@export var audio_player: AudioStreamPlayer2D

var knockback_direction: Vector2 = Vector2.ZERO
var is_invulnerable: bool = false
var collision_shape: CollisionShape2D
var camera: ShakingCamera

signal hit_received 

func disable() -> void:
	collision_shape.set_deferred("disabled", true)

func enable() -> void:
	collision_shape.set_deferred("disabled", false)

func _ready() -> void:
	camera = get_tree().get_first_node_in_group("Camera")
	area_entered.connect(_on_hurtbox_entered)
	collision_shape = $CollisionShape2D
	
func _on_hurtbox_entered(area2d: Area2D) -> void:
	if is_invulnerable:
		return

	var hitbox = area2d as HitboxComponent
	if hitbox == null:
		return

	if sprite_flash:
		sprite_flash.flash()

	if enable_camera_shake:
		camera.screen_shake(1, 0.25)

	health_component.subtract_health(hitbox.damage)
	var target_dir = hitbox.global_position.direction_to(global_position) 
	if is_equal_approx(target_dir.x, 0.0):
		if hitbox.owner and "direction" in hitbox.owner:
			target_dir.x = hitbox.owner.direction
		else:
			target_dir.x = 1.0 

	knockback_direction = target_dir

	audio_player.play()

	hit_received.emit()
	
	if invulnerability_time <= 0:
		return

	is_invulnerable = true
	var invulnerability_timer = Timer.new()
	invulnerability_timer.wait_time = invulnerability_time
	invulnerability_timer.one_shot = true
	invulnerability_timer.timeout.connect(_on_invulnerability_timer_timeout)
	add_child(invulnerability_timer)
	invulnerability_timer.start()

func _on_invulnerability_timer_timeout() -> void:
	is_invulnerable = false
