class_name PlayerSprintJump
extends State

@export var idle_state: State
@export var run_state: State
@export var crouch_state: State

var player: Player
var start: Vector2
var is_jump_buffered: bool = false
var is_falling: bool = false

func _ready() -> void:
	player = owner as Player

func enter() -> void:
	play_entry_animation()
	player.sprite.animation_finished.connect(_on_sprint_jump_animation_finished)
	player.velocity.y = -player.sprint_speed * 1.4
	player.velocity.x = player.sprint_speed * sign(player.direction) 
	start = player.global_position

func exit() -> void:
	is_jump_buffered = false
	is_falling = false
	player.sprite.animation_finished.disconnect(_on_sprint_jump_animation_finished)

func process_physics(delta: float) -> State:
	if player.velocity.y >= 0:
		if player.input_component.can_buffer_jump():
			is_jump_buffered = true

		if player.is_on_floor():
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
