extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	print (bodies)
