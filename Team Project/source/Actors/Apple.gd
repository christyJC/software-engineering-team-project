extends Area2D

# The 'body' parameter refers to the entity that entered its collider
# only the Player can collect items
func _on_Apple_body_entered(body):
	queue_free() # Delete item when collected
	
	# Call the player's recieve item method
	# Give the player one apple
	body.recieveItem("apple",1)
