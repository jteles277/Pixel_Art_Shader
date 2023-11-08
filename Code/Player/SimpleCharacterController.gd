extends CharacterBody3D

@export var speed: float = 3
@export var extra_n_proj = 1
@export var rate_of_fire = 10

@export var Projectile: Resource
@export var Fire_position: CharacterBody3D
@export var camera: Camera3D
@export var body: Node3D
@export var viewport: SubViewport 
@export var weight: float 

var fire_direction =Vector3(0,0,0) 
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called every frame
func _physics_process(delta):
	handle_rotation(delta)
	handle_movement(delta)

# Handles Movement 
func handle_movement(delta):
	
	# Get the forward and right vectors of the camera
	var forward = camera.global_transform.basis.z
	forward.y = 0
	var right = camera.global_transform.basis.x
	right.y = 0

	# Get the input
	var input:Vector2 = Input.get_vector("left","right","forwards","backwards")
	var direction:Vector3 = Vector3(input.x,0,input.y)

	# Make direction relative to the camera
	direction = forward * direction.z + right * direction.x
	direction = direction.normalized() 
	
	# Jump when space is pressed
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += 5

	# Rotate the Camera if the right mouse click is pressed
	if(Input.is_action_pressed("right_mouse")):
		rotation_degrees.y +=1 ; 

	#Set velocity and move
	velocity = Vector3(
					direction.x * speed,
					velocity.y - gravity * delta,
					direction.z * speed
				)  
	move_and_slide()

# Handles Player Rotattion 
func handle_rotation(delta):
	
	# Get mouse position in the screen and the space state
	var space_state = get_world_3d().direct_space_state   
	var mouse_position = get_viewport().get_mouse_position() 
	
	# Rescale to the current subview size
	var screen_size = get_tree().get_root().size   
	var x_ratio = float(viewport.size.x) / screen_size.x
	var y_ratio = float(viewport.size.y) / screen_size.y 
	mouse_position = Vector2(mouse_position.x * x_ratio, mouse_position.y* y_ratio) 
	
	# Create a raycast from the mouse position in the screen to the floor
	var rayOrigin = camera.project_ray_origin(mouse_position)	
	var rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 2000
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	
	# Get all intersections of the raycast with the ground 
	var intersection = space_state.intersect_ray(query)   
	
	# If there is ant intersections
	if not intersection.is_empty(): 
		# We get the position
		var pos = intersection.position  
		
		# Rotate the player body to looka at that direction
		body.look_at(Vector3(pos.x,position.y,pos.z), Vector3(0,1,0))  
 
		body.rotation.y = body.rotation.y + 80 
		
		# Set the fire direction to be the mouse direction
		fire_direction = pos - position
	
	# Fire when the left mouse button is pressed
	if(Input.is_action_just_pressed("left_mouse") && fire_direction != Vector3(0,0,0)):
		fire(fire_direction) 

# Fires an instance of the fire_ball projectile in the set <direction>
func fire(direction):
	for i in range(3):
		var projectile  = Projectile.instantiate()
		get_parent().add_child(projectile)
		projectile.position = Fire_position.global_position 
		projectile.velocity = direction
#	if (extra_n_proj != 0):
#		for i in range(extra_n_proj):
#			i = i+1 
#			var projectile2  = Projectile.instantiate()
#			get_parent().add_child(projectile2)
#			projectile2.position = Fire_position.global_position 
#			projectile2.velocity = Vector3(direction.x- (i*0.7), direction.y, direction.z- (i*0.7))  
#			var projectile3  = Projectile.instantiate()
#			get_parent().add_child(projectile3)
#			projectile3.position = Fire_position.global_position 
#			projectile3.velocity = Vector3(direction.x +(i*0.7) , direction.y, direction.z+(i*0.7))  
#			print(projectile2.velocity)
