class_name SpawnableEffect
extends Node2D

@export var isPlayer: bool
@export var player_sprite: AnimatedSprite2D
@export var boss_sprite: AnimatedSprite2D

func _ready() -> void:
	if isPlayer:
		player_sprite.play()
		return
	boss_sprite.play()

func _process(_delta: float) -> void:
	if !player_sprite.is_playing() and !boss_sprite.is_playing():
		queue_free()
	
