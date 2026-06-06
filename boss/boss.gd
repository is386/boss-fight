class_name Boss
extends Entity

@export var player: Player
@export var state_machine: StateMachine
@export var run_speed: float = 150
@export var jump_speed: float = 400

var isPlayerInRange: bool = false
var isInCooldown: bool
var canJump: bool = true
var is_phase_two: bool = false
var num_attacks = 0
var starting_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	super._ready()
	starting_position = global_position
	state_machine.init()

func _process(delta: float) -> void:
	if is_dead() || !is_instance_valid(player):
		return
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	if is_dead() || !is_instance_valid(player):
		return
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	if is_dead() || !is_instance_valid(player):
		return
	state_machine.process_input(event)
