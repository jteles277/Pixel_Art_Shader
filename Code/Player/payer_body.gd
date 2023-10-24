extends Node3D
@export var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	#Get the forward and right vectors of the camera
	var forward = camera.global_transform.basis.z
	forward.y = 0
	var right = camera.global_transform.basis.x
	right.y = 0
	
	#Get the input
	var input:Vector2 = Input.get_vector("left","right","forwards","backwards")
	var direction:Vector3 = Vector3(input.x,0,input.y)
	#Make direction relative to the camera  
	if direction!=Vector3(0,0,0):
		
		look_at(global_transform.origin + direction, Vector3.UP)
		rotation.y = rotation.y+ 80

	pass
