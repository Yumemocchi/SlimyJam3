extends Node


@onready var burst := false


func set_burst(b: bool):
	burst = b
	
func get_burst():
	return burst
	
