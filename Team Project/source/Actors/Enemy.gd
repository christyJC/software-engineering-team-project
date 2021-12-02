extends Actor

# makes it so the enemies start off moving to the left
func _ready() -> void: 
	set_physics_process(false)
	velocity.x = -speed.x

# reverses the direction of the enemy if they bump into a wall
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y
	
	# if the enemy's health reaches 0 they disappear
	if hitpoints == 0:
		queue_free()


func _on_BulletDetector_area_entered(area):
	hitpoints -= 25
