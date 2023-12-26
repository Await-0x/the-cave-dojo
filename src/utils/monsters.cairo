mod monster_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use array::ArrayTrait;
    use thecave::models::battle::{Monster, Battle, Creature};
    use thecave::utils::battle::battle_utils::battle_result;

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

    fn monster_attack(world: IWorldDispatcher, ref battle: Battle, ref monster: Monster) {
        let mut damage = 0;

        if monster.taunted {
            monster.taunted = false;
            
            let mut creature: Creature = get!(world, (monster.taunted_by, battle.id), Creature);

            if battle.round >= monster.enrage_turn.into() && monster.attack > creature.health && !creature.shield {
                damage += (monster.attack - creature.health);
            }

            battle_result(world, ref battle, ref creature, ref monster);
        } else {
            damage += monster.attack;
        }

        damage += monster.minions_attack;

        if damage >= battle.adventurer_health {
            battle.adventurer_health = 0;
        } else {
            battle.adventurer_health -= damage;
        }
    }
}