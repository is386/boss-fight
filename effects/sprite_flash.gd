class_name SpriteFlash
extends Node

var sprite: AnimatedSprite2D

func _ready() -> void:
	sprite = (owner as Entity).sprite
	
func flash() -> void:
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:v", 1, 0.2).from(30)
