extends Node3D

@onready var _timer = $Timer
@onready var _label_timer = $TimerLabel/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_label_timer.text = str(int(round(_timer.time_left)))
	if _timer.is_stopped() or Globals.vie <= 0:
		get_tree().change_scene_to_file("res://end.tscn")
	#if Globals.total_braseros == Globals.nb_brasero_up:
	if 2 == Globals.nb_brasero_up:
		var walls = get_tree().get_nodes_in_group("destructible_walls")
		for i in walls:
			i.queue_free()
		#get_tree().change_scene_to_file("res://good_end.tscn")
