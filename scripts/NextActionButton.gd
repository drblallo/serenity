extends Button


func _on_button_down() -> void:
	Rules.apply_random_action()
	
func _on_button_down_actions() -> void:
	Rules.apply_random_action()
	Rules.resolve_randomnmess()
