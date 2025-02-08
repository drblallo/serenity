import bounded_arg
import moves
import collections.vector

const CREATURE_MAX_TYPES_COUNT = 2
using CreatureTypes = BoundedVector<Type, CREATURE_MAX_TYPES_COUNT>

fun _make_creature_types(Type first, Type second) -> CreatureTypes:
    let to_return : CreatureTypes
    to_return.append(first)
    to_return.append(second)
    return to_return

fun _make_creature_types(Type first) -> CreatureTypes:
    let to_return : CreatureTypes
    to_return.append(first)
    return to_return


enum CreatureKind:
    lupinferno:
        CreatureTypes types = _make_creature_types(Type::fire, Type::dark)
    alpenglut:
        CreatureTypes types = _make_creature_types(Type::fire, Type::dark)
    flammezzo:
        CreatureTypes types = _make_creature_types(Type::fire)
    ignivetta:
        CreatureTypes types = _make_creature_types(Type::fire, Type::sun)
    brasaragno:
        CreatureTypes types = _make_creature_types(Type::fire, Type::earth)
    vulcervo:
        CreatureTypes types = _make_creature_types(Type::fire, Type::earth)
    laricefango:
        CreatureTypes types = _make_creature_types(Type::water, Type::earth)
    torbiera:
        CreatureTypes types = _make_creature_types(Type::water, Type::dark)
    lacumbria:
        CreatureTypes types = _make_creature_types(Type::water, Type::dark)
    nebeltropf:
        CreatureTypes types = _make_creature_types(Type::water, Type::sun)
    gorgoglione:
        CreatureTypes types = _make_creature_types(Type::water, Type::earth)
    stagnirpe:
        CreatureTypes types = _make_creature_types(Type::water, Type::dark)
    falkenblitz:
        CreatureTypes types = _make_creature_types(Type::electric, Type::sun)
    donnerkopf:
        CreatureTypes types = _make_creature_types(Type::electric)
    fulmivolo:
        CreatureTypes types = _make_creature_types(Type::electric, Type::sun)
    scintifarfalla:
        CreatureTypes types = _make_creature_types(Type::electric)
    stromluchs:
        CreatureTypes types = _make_creature_types(Type::electric, Type::dark)
    blitzmolch:
        CreatureTypes types = _make_creature_types(Type::electric, Type::water)
    luminara:
        CreatureTypes types = _make_creature_types(Type::sun, Type::electric)
    solcervo:
        CreatureTypes types = _make_creature_types(Type::sun, Type::earth)
    solvolpe:
        CreatureTypes types = _make_creature_types(Type::sun, Type::fire)
    aurorospino:
        CreatureTypes types = _make_creature_types(Type::sun, Type::earth)
    heliocasta:
        CreatureTypes types = _make_creature_types(Type::sun, Type::earth)
    glimmermaus:
        CreatureTypes types = _make_creature_types(Type::sun, Type::dark)
    eisenzahn:
        CreatureTypes types = _make_creature_types(Type::earth, Type::water)
    terramite:
        CreatureTypes types = _make_creature_types(Type::earth)
    granitauro:
        CreatureTypes types = _make_creature_types(Type::earth, Type::fire)
    rocciorso:
        CreatureTypes types = _make_creature_types(Type::earth, Type::dark)
    argillupo:
        CreatureTypes types = _make_creature_types(Type::earth, Type::water)
    humusnatter:
        CreatureTypes types = _make_creature_types(Type::earth, Type::dark)
    schattenfuchs:
        CreatureTypes types = _make_creature_types(Type::dark, Type::fire)
    nebelgeist:
        CreatureTypes types = _make_creature_types(Type::dark, Type::sun)
    tenebroso:
        CreatureTypes types = _make_creature_types(Type::dark, Type::earth)
    nachtflugel:
        CreatureTypes types = _make_creature_types(Type::dark, Type::sun)
    crepuscolma:
        CreatureTypes types = _make_creature_types(Type::dark, Type::water)
    finsterbar:
        CreatureTypes types = _make_creature_types(Type::dark, Type::earth)

using Stat = LinearlyDistributedInt<0, 10>
const CREATURE_MAX_MOVES_COUNT = 4
using CreatureMoves = BoundedVector<Move, CREATURE_MAX_TYPES_COUNT>

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
