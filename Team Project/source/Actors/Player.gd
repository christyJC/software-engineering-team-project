extends Actor

onready var animatedSprite = $animated
onready var inventory = {
	"apple":0,
	"ammo":10,
	"item" : "empty"
}


# if the player touches the enemy from the side he will lose 10 hitpoints
func _on_EnemyDetector_body_entered(body):
	hitpoints -= 10


func _physics_process(delta: float) -> void:
	set_health() #updates the players health as the game progresses
	set_items() #updates items
	is_dead() # kills the player if there are 0 hitpoints
	
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
	




# shows the player's health in the HUD
func set_health() -> void:
	get_node("HUD/Health/HealthLabel").set_text("Health: " + str(hitpoints))
	

# gets rid of the player if the player has no hitpoints
func is_dead() -> void:
	if hitpoints == 0:
		queue_free()
		get_tree().change_scene("res://source/Menus/GameOver.tscn")

# shows player's items in the HUD
func set_items() -> void:
	get_node("HUD/Apples/AppleLabel").set_text("Apples: " + str(inventory["apple"]))
	


# This method is called when the player walks into an item
# It does not need to be called on the Player.gd script
func recieveItem(type,recieved):
	if type == "apple":
		inventory["apple"] += recieved
		$AudioStreamPlayer2D.play()
		yield(get_tree().create_timer(.3), "timeout")
		$AudioStreamPlayer2D.stop()
	elif type == "ammo":
		inventory["ammo"] += recieved
	elif type == "item":
		inventory["item"] = recieved
	else:
		print("ERROR: Cannot give player this item/amounts")
		
	
	




