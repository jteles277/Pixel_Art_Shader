extends CharacterBody3D
@export var camera: Camera3D
@export var speed: float = 3
@export var Projectile: Resource
@export var Fire_position: CharacterBody3D
@export var extra_n_proj = 1
@export var rate_of_fire = 10

var fire_direction =Vector3(1,0,1)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func fire(dir):
	for i in range(3):
		var projectile  = Projectile.instantiate()
		get_parent().add_child(projectile)
		projectile.position = Fire_position.global_position 
		projectile.velocity = dir

#	if (extra_n_proj != 0):
#		for i in range(extra_n_proj):
#			i = i+1 
#			var projectile2  = Projectile.instantiate()
#			get_parent().add_child(projectile2)
#			projectile2.position = Fire_position.global_position 
#			projectile2.velocity = Vector3(dir.x- (i*0.7), dir.y, dir.z- (i*0.7))  
#			var projectile3  = Projectile.instantiate()
#			get_parent().add_child(projectile3)
#			projectile3.position = Fire_position.global_position 
#			projectile3.velocity = Vector3(dir.x +(i*0.7) , dir.y, dir.z+(i*0.7))  
#			print(projectile2.velocity)
func _physics_process(delta):
	#Get the forward and right vectors of the camera
	var forward = camera.global_transform.basis.z
	forward.y = 0
	var right = camera.global_transform.basis.x
	right.y = 0

	#Get the input
	var input:Vector2 = Input.get_vector("left","right","forwards","backwards")
	var direction:Vector3 = Vector3(input.x,0,input.y)

	#Make direction relative to the camera
	direction = forward * direction.z + right * direction.x
	direction = direction.normalized()
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += 5

	if(Input.is_action_just_pressed("right_mouse")):
		rotation_degrees.y += 45;
		
	if direction != Vector3(0,0,0):
		fire_direction = direction
	if(Input.is_action_just_pressed("left_mouse")):
		fire(fire_direction) 
	#Set velocity and move
	velocity = Vector3(
					direction.x * speed,
					velocity.y - gravity * delta,
					direction.z * speed
				)

	#Jump when space is pressed


	move_and_slide()

