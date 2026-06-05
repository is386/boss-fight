class_name HealthComponent
extends Node

@export var max_health: int

var current_health: int

func _ready() -> void:
	current_health = max_health
	print(owner.name, ' ', current_health)

func subtract_health(amount: int) -> void:
	current_health = max(current_health - amount, 0)
	print(owner.name, ' ', current_health)

