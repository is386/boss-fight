class_name PlayerMoveState
extends State

@export var hurt_state: State

var player: Player
var isHit: bool = false

func _ready() -> void:
	player = owner as Player

func enter() -> void:
	player.hurtbox_component.hit_received.connect(_on_hit_received)

func exit() -> void:
	if player.hurtbox_component.hit_received.is_connected(_on_hit_received):
		player.hurtbox_component.hit_received.disconnect(_on_hit_received)

func process(_delta: float) -> State:
	if isHit:
		isHit = false
		return hurt_state 
	return null

func _on_hit_received() -> void:
	isHit = true

