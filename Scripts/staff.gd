extends Node3D

#const OBJ_FIRE_FLAME: Object = preload("res://fire_flame.tscn")
@export var OBJ_FIRE_FLAME: PackedScene
@onready var is_fire_flame_pop := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.get_burst() and !is_fire_flame_pop:
		pop_fire_flame()
		
	if !Globals.get_burst() and is_fire_flame_pop:
		is_fire_flame_pop = false

		
	
func pop_fire_flame():
	print("pop flame")
	var fire_flame = OBJ_FIRE_FLAME.instantiate()
	fire_flame.position = Vector3i(0.076,2.982,-0.009)
	$Staff/fire.add_sibling(fire_flame)
	Globals.resting = false
	is_fire_flame_pop = true



func _on_timer_timeout():
	if !Globals.resting:
		Globals.mana -= Globals.power_mana
