extends Node


@onready var burst := false
@onready var mana := 100.0
@onready var resting := true
@onready var power_mana := 20
@onready var uptime_brasero := 5
@onready var total_braseros := 6
@onready var nb_brasero_up := 0

func set_burst(b: bool):
	burst = b
	
func get_burst():
	return burst
	
