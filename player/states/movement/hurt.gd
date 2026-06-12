class_name PlayerHurt
extends PlayerMoveState

@export var idle_state: State
@export var fall_state: State

func _ready() -> void:
	player = owner as Player

func enter() -> void:
	player.play_animation('hurt')
	player.velocity.x = 125 * sign(player.hurtbox_component.knockback_direction.x)
	player.velocity.y = 0
	Engine.time_scale = 0 
	await get_tree().create_timer(0.2, true, false, true).timeout
	Engine.time_scale = 1.0

func exit() -> void:
	player.dashed = false

func process(_delta: float) -> State:
	if !player.sprite.is_playing():
		if player.is_on_floor():
			return idle_state
		else:
			return fall_state
	return null

func process_physics(delta: float) -> State:
	player.velocity_component.apply_gravity(delta)
	player.move_and_slide()
	return null
