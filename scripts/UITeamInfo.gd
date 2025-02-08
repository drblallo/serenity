extends PanelContainer

var team : RLCTeam = null

func setup(new_team: RLCTeam):
	team = new_team
	if team == null:
		visible = false
		return
	visible = true
	for i in range($VBoxContainer.get_child_count()):
		$VBoxContainer.get_child(i).setup(Rules.library.get_creature(team, i))
