extends Actor

onready var animatedSprite = $animated

func _physics_process(delta: float) -> void:
	set_health() #updates the players health as the game progresses
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	#this is for animation of the character
	var axisX = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if axisX > 0: 
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = false
	elif axisX < 0:
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = true
	
	else:
		animatedSprite.animation = "idle"
		

func get_direction() -> Vector2:
	return Vector2(
		
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 
		
		if Input.is_action_just_pressed("jump") and is_on_floor() 
		
		else 1.0
	)


func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity
	




# shows the players health in the HUD
func set_health() -> void:
	get_node("HUD/Health").set_text("Health: " + str(hitpoints))
