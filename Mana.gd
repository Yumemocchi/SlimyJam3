extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.value = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureProgressBar.value = Globals.mana


func _on_timer_timeout():
	if Globals.resting:
		Globals.mana += Globals.power_mana
