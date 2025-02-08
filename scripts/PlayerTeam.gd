extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Rules.on_state_changed.connect(self.on_state_changed)

func on_state_changed():
	$UITeamInfo.setup(Rules.get_state().get_player_team())
