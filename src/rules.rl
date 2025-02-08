import string
import serialization.print
import machine_learning
import bounded_arg
import range

enum Type:
    fire
    water
    light
    dark
    earth
    thunder

enum CreatureKind:
    alpengoat

using Stat = LinearlyDistributedInt<0, 10>

cls Creature:
    CreatureKind kind
    Stat max_hp
    Stat current_hp
    Stat attack
    Stat defense
    Stat speed 

    fun is_knocked_out() -> Bool:
        return self.current_hp == 0

fun make_creature(CreatureKind kind, Int max_hp, Int attack, Int defense, Int speed) -> Creature:
    let creature : Creature
    creature.kind = kind
    creature.max_hp = max_hp
    creature.current_hp = max_hp
    creature.attack = attack
    creature.defense = defense
    creature.speed = speed
    return creature

const TEAM_SIZE = 6
cls Team:
    Creature[TEAM_SIZE] creatures

    fun is_wiped_out() -> Bool:
        for i in range(TEAM_SIZE):
            if !self.creatures[i].is_knocked_out():
               return false     
        return true

    fun get_creature(Int index) -> ref Creature:
        return self.creatures[index]

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
    for i in range(TEAM_SIZE):
        team.creatures[i] = make_creature(CreatureKind::alpengoat, 10, 1, 1, 1)
    return team

act battle(ctx Team team, ctx Team team2) -> Battle:
    while !team.is_wiped_out() and !team2.is_wiped_out():
        subaction*(team, team2) round = round(team, team2)

@classes
act play() -> Game:
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
    to_string(CreatureKind::alpengoat)
    to_string(enumerate(action))
    print(enumerate(action))
