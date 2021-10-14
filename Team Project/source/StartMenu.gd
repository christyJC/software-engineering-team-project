# Starter code and node setup from Jon Topielski
# Tutorial used: 
# 		https://www.youtube.com/watch?v=Jjv2MWbQVhs

extends MarginContainer

const gameStart = preload("res://source/Levels/LevelTemplate.tscn")
const optionsMenu = preload("res://source/OptionsMenu.tscn")

onready var selectorStart = $CenterContainer/VBoxContainer/StartGame/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selectorOptions = $CenterContainer/VBoxContainer/Options/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selectorExit = $CenterContainer/VBoxContainer/Exit/VBoxContainer/CenterContainer/HBoxContainer/Selector2

var activeSelection = 0

func _ready(): # Called at start of scence
	setSelection(0) # Put cursor at start at first

func _process(delta): # This is called every frame
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
	selectorOptions.text = "-"
	selectorExit.text = "-"
	
	# Check what is selected and update selector label
	if _activeSelection == 0:
		selectorStart.text = ">"
	elif _activeSelection == 1:
		selectorOptions.text = ">"
	elif _activeSelection == 2:
		selectorExit.text = ">"

# Check for looping (going down when at the bottom / going up while at the top)
func checkInput(_activeSelection):
	if activeSelection > 2:
		activeSelection = 0
	if activeSelection < 0:
		activeSelection = 2


func makeSelection(_activeSelection):
	if activeSelection == 0:
		get_parent().add_child(gameStart.instance())
		queue_free()
		
	elif activeSelection == 1:
		get_parent().add_child(optionsMenu.instance())
		queue_free()
	
	elif activeSelection == 2:
		get_tree().quit()
