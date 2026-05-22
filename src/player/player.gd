class_name Player
extends CharacterBody2D

@export var state_machine: StateMachine 
@export var sprite: AnimatedSprite2D 
@export var movement_component: MovementComponent
@export var velocity_component: VelocityComponent
@export var move_speed: float
@export var sprint_speed: float
@export var jump_speed: float
@export var crouch_walk_speed: float
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
