extends MarginContainer

onready var selectorRetry = $CenterContainer/VBoxContainer/Exit/VBoxContainer/CenterContainer/HBoxContainer/SelectorRetry
onready var selectorQuit = $CenterContainer/VBoxContainer/Exit2/VBoxContainer/CenterContainer/HBoxContainer/SelectorQuit

var activeSelection = 0

func _ready():
	setSelection(0)

func _process(delta):
	if Input.is_action_just_pressed("ui_down"): # When arrow down is pressed
		activeSelection += 1 # Move to the next selection
		checkInput(activeSelection) # Check for looping
		setSelection(activeSelection) # Move cursor
		
	elif Input.is_action_just_pressed("ui_up"): # When arrow up is pressed
		activeSelection -= 1 # Move to next selection
		checkInput(activeSelection) # Check for looping
		setSelection(activeSelection) # Move cursor
	
	elif Input.is_action_just_pressed("ui_accept"):
		makeSelection(activeSelection)


func setSelection(_activeSelection): 
	# Set all selector labels to "-"
	selectorRetry.text = "-"
	selectorQuit.text = "-"
	
	# Check what is selected and update selector label
	if _activeSelection == 0:
		selectorRetry.text = ">"
	elif _activeSelection == 1:
		selectorQuit.text = ">"


func checkInput(_activeSelection):
	if activeSelection > 1:
		activeSelection = 0
	if activeSelection < 0:
		activeSelection = 1


func makeSelection(_activeSelection):
	if activeSelection == 0:
		get_tree().change_scene("res://source/Levels/LevelTemplate.tscn")
	elif activeSelection == 1:
		get_tree().quit()
