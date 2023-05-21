extends Node


@onready var burst := false
@onready var mana := 50.0

func set_burst(b: bool):
	burst = b
	
func get_burst():
	return burst
	
