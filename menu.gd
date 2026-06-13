extends Node

@export var animation_player: AnimationPlayer
@export var start_button: TextureButton
@export var endless_button: TextureButton
@export var exit_button: TextureButton
@export var focus_audio: AudioStreamPlayer2D

func _ready() -> void:
	start_button.call_deferred("grab_focus")

func go_to_main():
	var main_scene = load("res://main.tscn") as PackedScene
	var main = main_scene.instantiate() as Main
	main.is_endless = false
	get_tree().root.add_child(main)
	get_tree().current_scene = main
	queue_free()

func go_to_main_endless():
	var main_scene = load("res://main.tscn") as PackedScene
	var main = main_scene.instantiate() as Main
	main.is_endless = true 
	get_tree().root.add_child(main)
	get_tree().current_scene = main
	queue_free()

func play_focus_sound():
	focus_audio.play()

func release_focus():
	var current_focus = get_viewport().gui_get_focus_owner()
	if current_focus:
		current_focus.release_focus()

func _on_start_button():
	release_focus()
	animation_player.play("fade_out")

func _on_endless_button():
	release_focus()
	animation_player.play("fade_out_endless")

func _on_exit_button():
	release_focus()
	get_tree().quit()
