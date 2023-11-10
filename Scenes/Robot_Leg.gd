extends Node3D 

@export var body: Node3D

@export var right_footSpacing: float
@export var forward_footSpacing: float
@export var spacing: float = 1.0
@export var move_treshhold: float
@export var speed: float 
@export var stepHeight: float

@export var Gizmo: Resource
var gizmo;
var distance = 0
var lerp: float = 0.0
var new_position = Vector3(0,0,0)
var current_position = global_position
var old_position = Vector3(0,0,0)

# Called when the node enters the scene trvar positionee for the first time.
func _ready():
	right_footSpacing = right_footSpacing*spacing
	forward_footSpacing = forward_footSpacing*spacing
	
	#gizmo = Gizmo.instantiate()
	#add_child(gizmo) 
	
	pass # Replace with function body.

func _update_gizmos():
	#gizmo.global_position = new_position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):  
	
	_update_gizmos() 
	
	global_position = current_position
	# Get all intersections of the raycast with the ground 
	var intersection = get_down_raycast_intersection()
	
	# If there is ant intersections
	if not intersection.is_empty():
		
		distance = (new_position - intersection.position).length()  
		if distance >= move_treshhold:  
			new_position = intersection.position
			lerp = 0
	if (lerp < 1):
		
		var foot_position = old_position.lerp(new_position, lerp) 
		foot_position.y += sin(lerp *PI) * stepHeight
		current_position = foot_position 
		lerp += delta * float(speed)    
	else:
		old_position = new_position
		

func get_down_raycast_intersection():
	var space_state = get_world_3d().direct_space_state   
	var rayOrigin = body.global_position + (body.basis.z * right_footSpacing) + (body.basis.x * forward_footSpacing) 
	var rayEnd = rayOrigin + body.basis.y * -2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	query.exclude = [self]
	# Get all intersections of the raycast with the ground 
	return space_state.intersect_ray(query)  
