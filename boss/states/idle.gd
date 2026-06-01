class_name BossIdle
extends State

var boss: Boss

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation("idle")	
	boss.velocity.x = 0
