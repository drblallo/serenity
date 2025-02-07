extends Node

var library = RLCLib.new()
var state = null
var all_actions = null
var valid_actions = null
var rng = RandomNumberGenerator.new()
signal on_action_applied
signal on_state_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	state = library.play()
	var alias = RLCAnyGameAction.make()
	all_actions = library.enumerate(alias)
	valid_actions = _valid_actions()
 # Replace with function body.

func resolve_randomnmess():
	while library.get_current_player(state) == -1:
		_apply_random_action()
	on_state_changed.emit()
		
func _valid_actions():
	var l = []
	for i in range(library.size(all_actions)):
		var action = library.get(all_actions, i)
		if library.can_apply(action, state):
			l.append(action)
	return l

func apply_random_action():
	_apply_random_action()
	on_state_changed.emit()

func _apply_random_action():
	var actions = valid_actions
	if len(actions) == 0:
		return
	var selected = actions[rng.randi_range(0, len(actions)-1)]
	_apply_action(selected)
	on_action_applied.emit(selected)


func strip_symbols(s: String) -> String:
	return s.replace("[", "").replace("]", "").replace(",", "").replace("{", "").replace("}", "").to_snake_case().replace("_", " ")

func get_state() -> RLCGame:
	return state as RLCGame

func can_apply(action):
	if not action is RLCAnyGameAction:
		var wrapperd = RLCAnyGameAction.make()
		wrapperd.assign(action)
		action = wrapperd
	return self.library.can_apply(action, state)
	
func _apply_action(action):
	library.apply(action, state)
	valid_actions = _valid_actions()
	
func apply_action(action):
	if not action is RLCAnyGameAction:
		var wrapperd = RLCAnyGameAction.make()
		wrapperd.assign(action)
		action = wrapperd
	if not library.can_apply(action, state):
		print("could not apply action")
		print_rlc(action)
		return
	_apply_action(action)
	on_action_applied.emit(action)
	on_state_changed.emit()


func get_units_counts() -> int:
	return library.size(get_state().get_board().get_units())
	
func print_rlc(rlc_object):
	print(as_str(rlc_object))

func as_str(rlc_object)  -> String:
	assert(rlc_object != null)
	var stringed = library.to_string(rlc_object)
	if stringed == null:
		print("obj could not be converted to string")
		return ""
	return library.convert_string(stringed)

func as_indented_str(rlc_object)  -> String:
	assert(rlc_object != null)
	return RLCLib.convert_string(library.to_indented_lines(library.to_string(rlc_object)))

func choise_is_random() -> bool:
	return library.get_current_player(state) == -1

func is_terminal() -> bool:
	return (state as RLCGame).get_resume_index() == -1

func score(player_id: int):
	return library.get_score((state as RLCGame).get_board(), player_id)
