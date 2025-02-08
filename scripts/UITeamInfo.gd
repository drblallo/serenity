extends PanelContainer

var team : RLCTeam = null

func setup(new_team: RLCTeam):
	team = new_team
	if team == null:
		visible = false
		return
	visible = true
	for i in range($VBoxContainer.get_child_count()):
		if i < Rules.library.size(team):
			$VBoxContainer.get_child(i).setup(Rules.library.get(team, i))
		else:
			$VBoxContainer.get_child(i).setup(null)
