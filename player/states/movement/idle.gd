class_name PlayerIdle
extends State

@export var run_state: State
@export var jump_state: State
@export var fall_state: State
@export var crouch_state: State
@export var dash_state: State

var player: Player

func _ready() -> void:
	player = owner as Player

func enter() -> void:
	player.is_idle = true
	if player.was_crouching:
		player.play_animation("get_up")
		player.sprite.animation_finished.connect(_on_get_up_animation_finished)
	else:
		play_entry_animation()
	player.velocity.x = 0

func exit() -> void:
	player.is_idle = false

func process_physics(_delta: float) -> State:
	if player.was_crouching:
		return
	if !player.is_on_floor():
		return fall_state
	if player.input_component.can_run():
		return run_state
	if player.input_component.can_jump():
		return jump_state
	if player.input_component.can_crouch():
		return crouch_state
	if player.input_component.can_dash():
		return dash_state
	return null

func _on_get_up_animation_finished() -> void:
	play_entry_animation()
	player.sprite.animation_finished.disconnect(_on_get_up_animation_finished)
	player.was_crouching = false

func play_entry_animation() -> void:
	player.play_animation("idle")	
