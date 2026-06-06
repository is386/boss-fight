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

func _ready() -> void:
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

