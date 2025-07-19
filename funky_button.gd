@tool

extends TextureButton
class_name FunkyButton

@export var prevButton: FunkyButton = null
var xOffset: int = 50

var expanded: bool = false
var expansionSize: int = 50

@onready var originalSize: Vector2 = self.size
@onready var expandedSize: Vector2 = Vector2(originalSize.x + expansionSize, originalSize.y + expansionSize)

@onready var poly: Polygon2D = $Polygon2D
@onready var originalPoly: PackedVector2Array = poly.polygon.duplicate()
@onready var expandedPoly: PackedVector2Array = getExpandedPolygon(originalPoly)

func getExpandedPolygon(ogPoly:PackedVector2Array) -> PackedVector2Array:
	var returnPoly: PackedVector2Array = ogPoly.duplicate()
	#expanded.set(1, Vector2(expanded.get(1).x + expansionSize, expanded.get(1).y))
	returnPoly.set(2, Vector2(returnPoly.get(2).x + expansionSize, returnPoly.get(2).y + expansionSize))
	returnPoly.set(3, Vector2(returnPoly.get(3).x + expansionSize, returnPoly.get(3).y + expansionSize))
	
	return  returnPoly

func _process(_delta:float) -> void:
	if prevButton != null:
		self.position.x = prevButton.position.x + xOffset + (expansionSize if prevButton.expanded else 0)
		
	if expanded:
		poly.polygon = expandedPoly
		self.custom_minimum_size = expandedSize
	else:
		poly.polygon = originalPoly
		self.custom_minimum_size = originalSize
	pass


func _on_mouse_entered() -> void:
	expanded = true
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	expanded = false
	pass # Replace with function body.
