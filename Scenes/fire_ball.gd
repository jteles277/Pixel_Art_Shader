extends CharacterBody3D
 
@export var speed = 10



func _physics_process(delta):
	var collision = move_and_collide(velocity.normalized() * speed * delta)
 
