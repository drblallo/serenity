import string
import serialization.print
import machine_learning
import bounded_arg
import collections.vector
import range
import creature
import moves

const TEAM_SIZE = 6
cls Team:
    BoundedVector<Creature, TEAM_SIZE> creatures

    fun is_wiped_out() -> Bool:
        for i in range(TEAM_SIZE):
            if !self.creatures[i].is_knocked_out():
               return false     
        return true

    fun get(Int index) -> ref Creature:
        return self.creatures[index]

    fun size() -> Int:
        return self.creatures.size()

    fun rotate():
        let first = self.creatures[0]
        for i in range(TEAM_SIZE - 1):
            self.creatures[i] = self.creatures[i + 1]
        self.creatures[TEAM_SIZE - 1] = first

act round(ctx Team team, ctx Team team2) -> Round:
    act deal_100_damage()
    team2.creatures[0].current_hp = team2.creatures[0].current_hp - 100

    if team2.creatures[0].current_hp == 0:
        team2.rotate()

fun make_team() -> Team:
    let team : Team
    team.creatures.append(make_creature(CreatureKind::lupinferno, 10, 1, 1, 1))
    team.creatures.append(make_creature(CreatureKind::ignivetta, 10, 1, 1, 1))
    team.creatures.append(make_creature(CreatureKind::vulcervo, 10, 1, 1, 1))
    team.creatures.append(make_creature(CreatureKind::falkenblitz, 10, 1, 1, 1))
    team.creatures.append(make_creature(CreatureKind::aurorospino, 10, 1, 1, 1))
    team.creatures.append(make_creature(CreatureKind::terramite, 10, 1, 1, 1))
    return team

act battle(ctx Team team, ctx Team team2) -> Battle:
    while !team.is_wiped_out() and !team2.is_wiped_out():
        subaction*(team, team2) round = round(team, team2)

@classes
act play() -> Game:
    act start_battle()
    frm player_team = make_team()
    frm cpu_team = make_team()
    subaction*(player_team, cpu_team) battle = battle(player_team, cpu_team)

fun score(Game g, Int player_id) -> Float:
    return 0.0

fun get_current_player(Game g) -> Int:
    return 0 

fun pretty_print(Game game):
    print_indented(game)

fun gen_methods():
    let x : Vector<Bool>
    let action : AnyGameAction
    let game = play()
    let creature : Creature
    to_string(creature)
    apply(action, game)
    to_string(action)
    print(action)
    to_string(CreatureKind::lupinferno)
    to_string(enumerate(action))
    print(enumerate(action))
