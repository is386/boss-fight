class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent
@export var invulnerability_time: float

var knockback_direction: Vector2 = Vector2.ZERO
var is_invulnerable: bool = false

signal hit_received 

func _ready() -> void:
	area_entered.connect(_on_hurtbox_entered)
	
func _on_hurtbox_entered(area2d: Area2D) -> void:
	if is_invulnerable:
		return

	var hitbox = area2d as HitboxComponent
	if hitbox == null:
		return

	health_component.subtract_health(hitbox.damage)
	knockback_direction = global_position.direction_to(hitbox.global_position).normalized() * -1

	is_invulnerable = true
	var invulnerability_timer = Timer.new()
	invulnerability_timer.wait_time = invulnerability_time
	invulnerability_timer.one_shot = true
	invulnerability_timer.timeout.connect(_on_invulnerability_timer_timeout)
	add_child(invulnerability_timer)
	invulnerability_timer.start()

	hit_received.emit()

func _on_invulnerability_timer_timeout() -> void:
	is_invulnerable = false
