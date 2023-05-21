extends Node


@onready var burst := false
@onready var mana := 100.0
@onready var resting := true
@onready var power_mana := 10
@onready var uptime_brasero := 5

func set_burst(b: bool):
	burst = b
	
func get_burst():
	return burst
	
