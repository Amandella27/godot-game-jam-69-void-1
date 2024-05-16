extends Node

class_name ShieldComponent

signal shield_changed(new_shield)

@onready var shield_regen_delay = $ShieldRegenDelay
@onready var shield_regen_timer = $ShieldRegenTimer

@export var max_shield: int
@export var regen_delay: int
@export var regen_rate: float


var current_shield
var ownerNode: Node

func _ready():
	current_shield = max_shield
	ownerNode = get_parent()
	shield_changed.emit(current_shield)
	shield_regen_delay.stop()
	
func adjust_shield(adjustment: int):
	if ownerNode is Enemy:
		current_shield += adjustment
	elif ownerNode is Player:
		Globals.total_damage_taken += adjustment
		current_shield = clamp(current_shield + adjustment, 0 , max_shield)
		shield_changed.emit(current_shield)
		shield_regen_delay.start(regen_delay)

func shield_regen():
	if shield_regen_delay.is_stopped():
		if ownerNode is Player and ownerNode.current_energy >= 1 and current_shield != max_shield:
			adjust_shield(1)
			shield_regen_delay.stop()
			shield_regen_timer.start(regen_rate)
			ownerNode.adjust_void_energy(-1)
	
func _on_shield_regen_delay_timeout():
	shield_regen_delay.stop()
	shield_regen()
	
func _on_shield_regen_timer_timeout():
	shield_regen()


