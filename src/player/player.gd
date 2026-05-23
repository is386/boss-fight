class_name Player
extends CharacterBody2D

@export var sprite: AnimatedSprite2D 
@export var state_machine: StateMachine 
@export var movement_component: MovementComponent
@export var velocity_component: VelocityComponent

@export_group("Run Parameters")
@export var enable_run: bool = true
@export var run_speed: float = 150

@export_group("Sprint Parameters")
@export var enable_sprint: bool = true
@export var enable_sprint_jump: bool = true
@export var sprint_speed: float = 300

@export_group("Jump Parameters")
@export var enable_jump: bool = true
@export var jump_speed: float = 400

@export_group("Crouch Parameters")
@export var enable_crouch: bool = true
@export var enable_crouch_walk: bool = true
@export var crouch_walk_speed: float = 50

@export_group("Dash Parameters")
@export var enable_dash: bool = true
@export var dash_speed: float = 500
@export var dash_distance: float = 100

var dashed = false
var direction = 1
var was_crouching = false

func _ready() -> void:
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
