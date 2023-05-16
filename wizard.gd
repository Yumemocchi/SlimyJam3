extends CharacterBody3D


const SPEED = 5.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var _wizard_mesh = $Armature/Wizard


func  _ready() -> void:
	#_animation.set("parameters/Blend3/blend_amount",-1)
	$pivot/Camera3D.near = -100
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() # * quaternion.from_euler(Vector3(0,0,0)
	print(direction)
	var is_attacking = Input.is_action_just_pressed("punch")

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	#	_animation.set("parameters/Blend3/blend_amount",1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	#	_animation.set("parameters/Blend3/blend_amount",-1)
	
	if is_attacking:
		print("attack")
		attack()		

	var rotation_speed = 5.0
	var target_rotation = atan2(input_dir.x, input_dir.y)
	_wizard_mesh.rotation.y = lerp_angle(_wizard_mesh.rotation.y, target_rotation, rotation_speed * delta)
	#_wizard_mesh.rotation.y = atan2(direction.x,direction.z)

	move_and_slide()
	

	
func attack():
	pass
	#_animation.set("parameters/OneShot/request", true)
