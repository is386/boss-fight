class_name Entity
extends CharacterBody2D

@export var sprite: AnimatedSprite2D 
@export var input_component: InputComponent
@export var velocity_component: VelocityComponent

var direction = 1

func play_animation(animation_name: String) -> void:
	sprite.play(animation_name)

