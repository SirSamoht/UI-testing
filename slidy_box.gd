@tool

extends VBoxContainer
class_name SlidyBox

#region "Variables"

@export var buttonsToGenerate: Array[String]

@export_category("Button Details")
@export var originalSize: Vector2
@export var slantAngle: float
@export var expansionSize: int
@export var expansionDuration: float

var slidyButton = preload("res://slidy_button.tscn")

@export var reloadData:bool:
	set(value):
		loadData()

#endregion

#region "functions"

func _ready() -> void:
	loadData()

func loadData():
	for child in self.get_children():
		self.remove_child(child)
	
	var lastButton: SlidyButton
	for buttonText: String in buttonsToGenerate:
		var newButton: SlidyButton = slidyButton.instantiate()
		
		newButton.text = buttonText
		
		# Setting the details for all buttons
		newButton.originalSize = originalSize
		newButton.slantAngle = deg_to_rad(slantAngle)
		newButton.expansionSize = expansionSize
		newButton.expansionDuration = expansionDuration
		newButton.seperationOffset = get_theme_constant("separation")
		
		#Connecting each button to the previous button
		if lastButton != null:
			newButton.prevButton = lastButton
		
		self.add_child(newButton)
		lastButton = newButton
		
#endregion
