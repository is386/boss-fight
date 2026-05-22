class_name PlayerSprintJump
extends State

@export var player: Player
@export var fall_state: State

var start: Vector2

func enter() -> void:
	player.sprite.play("sprint_jump")
	player.velocity.y = -player.sprint_speed
	player.velocity.x = player.sprint_speed * 1.25 * sign(player.direction) 
	start = player.global_position

func process_physics(_delta: float) -> State:
	var distance = player.global_position.distance_to(start)
	if distance >= player.dash_distance * 1.5:
		player.velocity.y = 0
		return fall_state

	player.move_and_slide()

	return null
		
