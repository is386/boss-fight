class_name PlayerRunningAttack
extends State

@export var idle_attack_state: State
@export var right_hitbox: HitboxComponent
@export var left_hitbox: HitboxComponent

var player: Player
var hitbox: HitboxComponent

func _ready() -> void:
	player = owner as Player

func enter() -> void:
	play_entry_animation()	
	player.is_attacking = true
	player.sprite.animation_finished.connect(_on_attack_animation_finished)

	if player.direction == 1:
		hitbox = right_hitbox
	else:
		hitbox = left_hitbox
	hitbox.enable()

func exit() -> void:
	hitbox.disable()
	player.is_attacking = false
	player.sprite.animation_finished.disconnect(_on_attack_animation_finished)

func process(_delta: float) -> State:
	if !player.is_attacking:
		return idle_attack_state
	return null

func _on_attack_animation_finished() -> void:
	player.is_attacking = false
	
func play_entry_animation() -> void:
	player.play_animation("running_attack")	
