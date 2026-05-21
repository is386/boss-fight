class_name PlayerDash
extends State

@export var player: Player
@export var fall_state: State

func enter() -> void:
	player.sprite.play("dash")
	player.dashed = true
	player.velocity.x = player.roll_speed 
	player.velocity.y = 0
	if player.sprite.flip_h:
		player.velocity.x *= -1

func process_physics(_delta: float) -> State:
	if not player.sprite.is_playing():
		return fall_state

	player.move_and_slide()
	return null
