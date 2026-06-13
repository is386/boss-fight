class_name HitTracker
extends Label

@export var boss: Boss

var hits = 0

func _ready() -> void:
	boss.hurtbox_component.hit_received.connect(_on_hit_received)

func _on_hit_received():
	hits += 1
	text = "Hits: %03d" % hits
