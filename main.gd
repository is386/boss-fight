class_name Main
extends Node

@export var player: Player
@export var boss: Boss
@export var audio_player: AudioStreamPlayer2D
@export var animation_player: AnimationPlayer
@export var hit_tracker: HitTracker

var is_endless: bool = false

func _ready() -> void:
	player.hurtbox_component.health_component.died.connect(_on_dead)
	boss.hurtbox_component.health_component.died.connect(_on_dead)
	audio_player.play()

	if not is_endless:
		hit_tracker.queue_free()
		return

	boss.hurtbox_component.health_component.max_health = 9999999
	boss.hurtbox_component.health_component.current_health = 9999999 
	boss.is_phase_two = true

func go_to_menu():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_dead():
	animation_player.play("fade_out")
