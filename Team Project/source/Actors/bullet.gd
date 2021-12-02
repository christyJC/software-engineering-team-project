extends Area2D


export var speed = 1500

func _ready():
	set_as_toplevel(true)
	
func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	
	
func _physics_process(delta):
	yield(get_tree().create_timer(5), "timeout")
	$sprite.frame = 0
	set_physics_process(false)

# The bullet disappears when it leaves the camera view
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


# The bullet disappears when it and enemy collision shape enters its area
func _on_Area2D_body_entered(body):
	queue_free()
