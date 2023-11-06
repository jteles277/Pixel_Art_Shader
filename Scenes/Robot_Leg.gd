extends Node3D 

@export var body: Node3D

@export var right_footSpacing: float
@export var forward_footSpacing: float
@export var spacing: float = 1.0
@export var move_treshhold: float
var distance = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	right_footSpacing = right_footSpacing*spacing
	forward_footSpacing = forward_footSpacing*spacing
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	
	var space_state = get_world_3d().direct_space_state   
	
	var rayOrigin = body.global_position + (body.basis.z * right_footSpacing) + (body.basis.x * forward_footSpacing) 
	var rayEnd = rayOrigin + body.basis.y * -2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	query.exclude = [self]
	# Get all intersections of the raycast with the ground 
	var intersection = space_state.intersect_ray(query)   
	
	
	
	# If there is ant intersections
	if not intersection.is_empty():  
		
		distance = (global_position - intersection.position).length() 
		if distance >= move_treshhold:
			global_position = intersection.position 
		
		
		
		print(intersection.position )
		
