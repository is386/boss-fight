class_name HitboxComponent
extends Area2D

@export var damage: int 

var collision_shape: CollisionShape2D

func _ready() -> void:
	collision_shape = $CollisionShape2D

func disable() -> void:
	collision_shape.set_deferred("disabled", true)

func enable() -> void:
	collision_shape.set_deferred("disabled", false)

