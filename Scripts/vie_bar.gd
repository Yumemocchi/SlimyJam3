extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.value = 100 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureProgressBar.value = Globals.vie
