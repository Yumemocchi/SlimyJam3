extends Control

const OBJ_FLAME: Object = preload("res://Asset/Images/flamme.png")
const OBJ_FLAME_COLOR: Object = preload("res://Asset/Images/flamme_color.png")
@onready var tab_flames = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in Globals.total_braseros:
		var flame = TextureRect.new()
		flame.texture = OBJ_FLAME
		flame.stretch_mode = TextureRect.STRETCH_SCALE
		flame.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		flame.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		flame.custom_minimum_size = Vector2(40,40)
		
		$HBoxContainer.add_child(flame)
		tab_flames.append(flame)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for f in tab_flames:
		f.texture = OBJ_FLAME
	
	if Globals.nb_brasero_up > 0:
		var i = 0
		for f in tab_flames:
			if i < Globals.nb_brasero_up:
				i += 1
				f.texture = OBJ_FLAME_COLOR
