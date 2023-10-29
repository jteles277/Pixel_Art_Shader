extends Node3D
@export var camera: Camera3D
@export var viewport: SubViewport

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	
	var space_state = get_world_3d().direct_space_state 
	var mouse_position = get_viewport().get_mouse_position() 
	var screen_size = get_tree().get_root().size   
	var x_ratio = float(viewport.size.x) / screen_size.x
	var y_ratio = float(viewport.size.y) / screen_size.y 
	mouse_position = Vector2(mouse_position.x * x_ratio, mouse_position.y* y_ratio) 
	var rayOrigin = camera.project_ray_origin(mouse_position)	
	var rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var intersection = space_state.intersect_ray(query)  
	if not intersection.is_empty():
		
		var pos = intersection.position
		
		look_at(Vector3(pos.x,pos.y,pos.z), Vector3(0,1,0))
		rotation.y = rotation.y + 80
 
