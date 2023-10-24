extends SubViewport

@export var pixelation: float = 50.0 

# Called when the node enters the scene tree for the first time.
func _ready():
	size.x = 1920*(1 - (pixelation/100.0))

	size.y = size.x/2  
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	pass
