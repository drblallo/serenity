import string
import serialization.print
import machine_learning

@classes
act play() -> Game:
    act something()

fun score(Game g, Int player_id) -> Float:
    return 0.0

fun get_current_player(Game g) -> Int:
    return 0 

fun pretty_print(Game game):
    print_indented(game)

fun gen_methods():
    let x : Vector<Bool>
    let action : AnyGameAction
    let game : Game 
    apply(action, game)
    to_string(action)
    print(action)
    to_string(enumerate(action))
    print(enumerate(action))
