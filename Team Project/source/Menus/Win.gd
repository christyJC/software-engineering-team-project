extends MarginContainer

onready var selectorStart = $CenterContainer/VBoxContainer/Exit/VBoxContainer/CenterContainer/HBoxContainer/SelectorStart
onready var selectorQuit = $CenterContainer/VBoxContainer/Exit2/VBoxContainer/CenterContainer/HBoxContainer/SelectorQuit

var activeSelection = 0

func _ready(): # Called at start of scence
	setSelection(0) # Put cursor at start at first

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
	selectorStart.text = "-"
	selectorQuit.text = "-"
	
	# Check what is selected and update selector label
	if _activeSelection == 0:
		selectorStart.text = ">"
	elif _activeSelection == 1:
		selectorQuit.text = ">"

# Check for looping (going down when at the bottom / going up while at the top)
func checkInput(_activeSelection):
	if activeSelection > 1:
		activeSelection = 0
	if activeSelection < 0:
		activeSelection = 1

# Makes a selection, either sending back to first level or leaving the game
func makeSelection(_activeSelection):
	if activeSelection == 0:
		get_tree().change_scene('res://source/Menus/StartMenu.tscn')
	elif activeSelection == 1:
		get_tree().quit()
