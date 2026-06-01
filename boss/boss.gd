class_name Boss
extends Entity

@export var state_machine: StateMachine

func _ready() -> void:
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

