class_name PlayerHealthBar
extends Control

@export var health_container: HBoxContainer
@export var	player_health_unit_scene: PackedScene	
@export var player: Player

var health_units: Array[PlayerHealthUnit]

func _ready() -> void:
	for i in range(player.hurtbox_component.health_component.max_health):
		var player_health_unit = player_health_unit_scene.instantiate()
		health_container.add_child(player_health_unit)
		health_units.append(player_health_unit)

func _process(_delta: float) -> void:
	if not player:
		return

	for i in range(player.hurtbox_component.health_component.current_health, player.hurtbox_component.health_component.max_health):
		health_units[i].set_empty()
