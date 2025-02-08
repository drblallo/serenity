extends PanelContainer

var current : RLCCreature = null

func setup(new_creature: RLCCreature) -> void:
	current = new_creature
	populate()
	
func populate():
	if current == null:
		visible = false
		return
	visible = true
	$Content/Info/HPs.text = str(current.get_current_hp().get_value()) + "/" + str(current.get_max_hp().get_value())
	$Content/Info/Name.text = Rules.as_str(current.get_kind())
	


func _on_mouse_entered() -> void:
	if current != null:
		GlobalPopup.ItemPopup(get_global_mouse_position(), Rules.as_str(current.get_kind()), Rules.strip_symbols(Rules.as_indented_str(current)), self)


func _on_mouse_exited() -> void:
	GlobalPopup.HideItemPopup(self)
