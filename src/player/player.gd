class_name Player
extends CharacterBody2D

@export var sprite: AnimatedSprite2D 
@export var state_machine: StateMachine 
@export var movement_component: MovementComponent
@export var velocity_component: VelocityComponent

@export_group("Move Parameters")
@export var enable_move: bool = true
@export var move_speed: float

@export_group("Sprint Parameters")
@export var enable_sprint: bool = true
@export var enable_sprint_jump: bool = true
@export var sprint_speed: float

@export_group("Jump Parameters")
@export var enable_jump: bool = true
@export var jump_speed: float

@export_group("Crouch Parameters")
@export var enable_crouch: bool = true
@export var enable_crouch_walk: bool = true
@export var crouch_walk_speed: float

@export_group("Dash Parameters")
@export var enable_dash: bool = true
@export var dash_speed: float
@export var dash_distance: float

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
