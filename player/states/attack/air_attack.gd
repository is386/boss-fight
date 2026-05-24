class_name PlayerAirAttack
extends State

@export var idle_attack_state: State

var player: Player

func _ready() -> void:
	player = owner as Player

func enter() -> void:
	play_entry_animation()	
	player.is_attacking = true
	player.sprite.animation_finished.connect(_on_attack_animation_finished)

func exit() -> void:
	player.is_attacking = false
	player.sprite.animation_finished.disconnect(_on_attack_animation_finished)

func process(_delta: float) -> State:
	if !player.is_attacking or player.is_on_floor():
		return idle_attack_state
	return null

func _on_attack_animation_finished() -> void:
	player.is_attacking = false
	
func play_entry_animation() -> void:
	player.play_animation("air_attack")	
