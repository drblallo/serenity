extends Control

@export var player_team : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	Rules.on_state_changed.connect(self.on_state_changed)

func on_state_changed():
	self.visible = true
	if player_team:
		$UITeamInfo.setup(Rules.get_state().get_player_team())
	else:
		$UITeamInfo.setup(Rules.get_state().get_cpu_team())
