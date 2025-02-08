extends CanvasLayer

var sender = null

func ItemPopup(position: Vector2, title: String, content: String, identifier):
	position = Vector2(position.x + 30, position.y + 30)
	$Tooltip/VBoxContainer/Title.text = title
	$Tooltip/VBoxContainer/Content.text = content
	$Tooltip.size = Vector2i.ZERO
	$Tooltip.popup(Rect2i(position, $Tooltip.size))
	$Tooltip/VBoxContainer.modulate =  Color(1, 1, 1, 0)
	sender = identifier

func HideItemPopup(identifier):
	if sender == identifier:
		$Tooltip.hide()
	
func _ready() -> void:
	propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_IGNORE])

func _process(delta):
	if $Tooltip.visible:
		$Tooltip/VBoxContainer.modulate = lerp($Tooltip/VBoxContainer.modulate, Color(1, 1, 1, 1), 0.01)
