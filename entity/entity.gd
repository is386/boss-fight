class_name Entity
extends CharacterBody2D

@export var sprite: AnimatedSprite2D 
@export var effect_sprite: AnimatedSprite2D 
@export var input_component: InputComponent
@export var velocity_component: VelocityComponent
@export var hurtbox_component: HurtboxComponent
@export var audio_player: AudioStreamPlayer2D

var direction = 1

func _ready() -> void:
	hurtbox_component.health_component.died.connect(_on_died)

func play_animation(animation_name: String) -> void:
	sprite.play(animation_name)

func play_effect(effect_name: String) -> void:
	effect_sprite.play(effect_name)

func _on_died() -> void:
	audio_player.play()
	play_animation("die")
	await sprite.animation_finished
	queue_free()

func is_dead() -> bool:
	return hurtbox_component.health_component.is_dead()	
