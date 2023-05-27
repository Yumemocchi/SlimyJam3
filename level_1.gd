extends Node3D

@onready var _timer = $Timer
@onready var _label_timer = $TimerLabel/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_label_timer.text = str(int(round(_timer.time_left)))
