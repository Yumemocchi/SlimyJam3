extends Node


@onready var burst := false

@onready var mana := 100.0
@onready var power_mana := 20

@onready var resting := true

@onready var uptime_brasero := 20
@onready var total_braseros := 3
@onready var nb_brasero_up := 0

@onready var vie := 100.0
@onready var hurt_power := 20.0

func set_burst(b: bool):
	burst = b
	
func get_burst():
	return burst
	
