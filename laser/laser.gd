class_name Laser
extends Node2D

@export var sprite: AnimatedSprite2D

func _process(_delta: float) -> void:
	if sprite and !sprite.is_playing():
		queue_free()
