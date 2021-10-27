extends MarginContainer

#TODO: Apply difficulty setting to game

onready var selectorEasy = $CenterContainer/VBoxContainer/Exit/VBoxContainer/CenterContainer/HBoxContainer/SelectorEasy
onready var choiceEasy = $CenterContainer/VBoxContainer/Exit/VBoxContainer/CenterContainer/HBoxContainer/EasyLabel/ChoiceEasy

onready var selectorMedium = $CenterContainer/VBoxContainer/Exit2/VBoxContainer/CenterContainer/HBoxContainer/SelectorMedium
onready var choiceMedium = $CenterContainer/VBoxContainer/Exit2/VBoxContainer/CenterContainer/HBoxContainer/Medium/ChoiceMedium

onready var selectorHard = $CenterContainer/VBoxContainer/Exit3/VBoxContainer/CenterContainer/HBoxContainer/SelectorHard
onready var choiceHard = $CenterContainer/VBoxContainer/Exit3/VBoxContainer/CenterContainer/HBoxContainer/HardLabel/ChoiceHard

onready var selectorReturn = $CenterContainer/VBoxContainer/Exit4/VBoxContainer/CenterContainer/HBoxContainer/SelectorReturn

var activeSelection = 0
var difficulty = "medium"

func _ready(): # Called at start of scence
	setSelection(0) # Put cursor at start at first
	clearChoices() # Show no difficulty choice
	# TODO: Make default difficulty "Medium" on game start only

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
	selectorEasy.text = "-"
	selectorMedium.text = "-"
	selectorHard.text = "-"
	selectorReturn.text = "-"
	
	# Check what is selected and update selector label
	if _activeSelection == 0:
		selectorEasy.text = ">"
	elif _activeSelection == 1:
		selectorMedium.text = ">"
	elif _activeSelection == 2:
		selectorHard.text = ">"
	elif _activeSelection == 3:
		selectorReturn.text = ">"
		
# Check for looping (going down when at the bottom / going up while at the top)
func checkInput(_activeSelection):
	if activeSelection > 3:
		activeSelection = 0
	if activeSelection < 0:
		activeSelection = 3

# the <-- signifies the user's difficulty setting
func makeSelection(_activeSelection):
	if activeSelection == 0:
		clearChoices()
		choiceEasy.text = "<--"
		
	elif activeSelection == 1:
		clearChoices()
		choiceMedium.text = "<--"
		
	elif activeSelection == 2:
		clearChoices()
		choiceHard.text = "<--"
		
	elif activeSelection == 3:
		get_tree().change_scene('res://source/Menus/StartMenu.tscn')

func clearChoices():
	choiceEasy.text = ""
	choiceMedium.text = ""
	choiceHard.text = ""
