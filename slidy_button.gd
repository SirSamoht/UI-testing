@tool

extends TextureButton
class_name SlidyButton

#region "Variables"

@onready var poly:Polygon2D = %Polygon2D

var expanded:bool = false:
	set(value):
		expanded = value
		var tween: Tween = create_tween()
		#tween.set_parallel(true)
		
		if expanded:
			tween.tween_property(self, "currentSize", Vector2(originalSize.x + (expansionSize / tan(slantAngle)), originalSize.y + expansionSize), expansionDuration)
			#tween.tween_property(self, "slantOffset", slantWidth + expansionSize, expansionDuration)
		else:
			tween.tween_property(self, "currentSize", Vector2(originalSize.x, originalSize.y), expansionDuration)
			#tween.tween_property(self, "slantOffset", slantWidth, expansionDuration)

var text:String

var prevButton: SlidyButton

var originalSize: Vector2
var slantAngle: float = 45
var slantWidth: int
var expansionSize: int
var expansionDuration: float

var currentSize: Vector2

var xOffset: int
var seperationOffset: int = 0

#endregion

#region "functions"

func _ready() -> void:
	currentSize = originalSize

func _process(_delta:float) -> void:
	poly.polygon = createPolygon()
	
	self.size = currentSize
	self.custom_minimum_size = currentSize
	pass
	
func createPolygon() -> PackedVector2Array:
	var returnArray: PackedVector2Array = []
	
	xOffset = 0
	if prevButton != null:
		xOffset = prevButton.xOffset + prevButton.slantWidth
	xOffset +=  seperationOffset
	
	slantWidth = currentSize.y / tan(slantAngle)
	
	returnArray.append(Vector2(xOffset,0))
	returnArray.append(Vector2(xOffset + currentSize.x - slantWidth,0))
	returnArray.append(Vector2(xOffset + currentSize.x, currentSize.y))
	returnArray.append(Vector2(xOffset + slantWidth,currentSize.y))
	
	return returnArray

#endregion

#region "Handlers"

func _on_mouse_entered() -> void:
	expanded = true
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	expanded = false
	pass # Replace with function body.

#endregion
