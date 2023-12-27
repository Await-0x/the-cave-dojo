mod monster_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use array::ArrayTrait;
    use thecave::models::battle::{Monster, Battle, Creature, Board, RoundEffects, GlobalEffects};
    use thecave::utils::{
        battle::battle_utils::battle_result,
        board::board_utils
    };

    fn get_monster(battle_id: usize, battles_won: u16) -> Monster {
        // let monster_id = battles_won % 7;
        let monster_id = 401;

        return Monster {
            battle_id,
            monster_id,
            attack: 0,
            health: 160,
            enrage_turn: 10,
            taunted: false,
            taunted_by: 0,
            minions_attack: 0
        };
    }

    fn monster_attack(
        world: IWorldDispatcher,
        ref battle: Battle,
        ref monster: Monster,
        ref board: Board,
        ref round_effects: RoundEffects,
        ref global_effects: GlobalEffects
    ) {
        let mut damage = 0;

        if monster.taunted == true {
            monster.taunted = false;
        
            let mut creature = board_utils::get_creature_by_id(ref board, monster.taunted_by);

            if creature.card_id != 0 {
                if battle.round >= monster.enrage_turn.into() && monster.attack > creature.health && !creature.shield {
                    damage += (monster.attack - creature.health);
                }

                battle_result(world, ref battle, ref creature, ref monster, ref board, ref round_effects, ref global_effects);
            } else {
                damage += monster.attack;
            }
        } else {
            damage += monster.attack;
        }

        if damage >= battle.adventurer_health {
            battle.adventurer_health = 0;
        } else {
            battle.adventurer_health -= damage;
        }
    }
}