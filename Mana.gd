extends Control
#<a href="https://www.freepik.com/free-vector/hand-drawn-video-game-element_40128288.htm#query=game%20progress%20bar&position=0&from_view=keyword&track=ais">Image by pikisuperstar</a> on Freepik

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.value = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureProgressBar.value = Globals.mana


func _on_timer_timeout():
	if Globals.resting and Globals.mana < 100:
		Globals.mana += Globals.power_mana
