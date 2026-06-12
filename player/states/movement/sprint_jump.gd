class_name PlayerSprintJump
extends PlayerMoveState

@export var idle_state: State
@export var run_state: State
@export var crouch_state: State
@export var jump_effect_scene: PackedScene
@export var landing_effect_scene: PackedScene

var start: Vector2
var is_jump_buffered: bool = false
var is_falling: bool = false

func enter() -> void:
	super.enter()
	play_entry_animation()
	player.sprite.animation_finished.connect(_on_sprint_jump_animation_finished)
	player.velocity.y = -player.sprint_speed * 1.4
	player.velocity.x = player.sprint_speed * sign(player.direction) 
	start = player.global_position

	var jump_effect = jump_effect_scene.instantiate() as SpawnableEffect
	jump_effect.isPlayer = true
	jump_effect.global_position = player.global_position 
	add_child(jump_effect)

func exit() -> void:
	super.exit()
	is_jump_buffered = false
	is_falling = false
	player.sprite.animation_finished.disconnect(_on_sprint_jump_animation_finished)

func process_physics(delta: float) -> State:
	if player.velocity.y >= 0:
		if player.input_component.can_buffer_jump():
			is_jump_buffered = true

		if player.is_on_floor():
			var landing_effect = landing_effect_scene.instantiate() as SpawnableEffect
			landing_effect.isPlayer = true
			landing_effect.global_position = player.global_position 
			add_child(landing_effect)

			if is_jump_buffered:
				is_jump_buffered = false
				return self 
			if player.input_component.can_crouch():
				return crouch_state
			if player.input_component.can_run():
				return run_state
			return idle_state

	player.velocity_component.apply_gravity(delta)
	player.move_and_slide()

	return null

func _on_sprint_jump_animation_finished() -> void:
	is_falling = true
	play_entry_animation()

func play_entry_animation() -> void:
	if is_falling:
		player.play_animation("sprint_jump_loop")
	else:
		player.play_animation("sprint_jump")	
