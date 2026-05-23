class_name PlayerStandingAttack
extends State

@export var idle_attack_state: State

func enter() -> void:
	play_entry_animation()	
	player.is_attacking = true
	player.sprite.animation_finished.connect(_on_standing_attack_animation_finished)

func exit() -> void:
	player.is_attacking = false
	player.sprite.animation_finished.disconnect(_on_standing_attack_animation_finished)

func process(_delta: float) -> State:
	if !player.is_attacking:
		return idle_attack_state
	if !player.is_idle:
		return idle_attack_state
	return null

func _on_standing_attack_animation_finished() -> void:
	player.is_attacking = false
	
func play_entry_animation() -> void:
	player.play_animation("standing_attack")	
