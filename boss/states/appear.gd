class_name BossAppear
extends State

@export var idle_state: State

var boss: Boss

func _ready() -> void:
	boss = owner as Boss

func enter() -> void:
	boss.play_animation("appear")	

func process(_delta: float) -> State:
	if !boss.sprite.is_playing():	
		return idle_state
	return null

