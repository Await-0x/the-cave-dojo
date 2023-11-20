mod monster_utils {
    use array::ArrayTrait;
    use thecave::models::battle::{Monster, Battle};
    use thecave::utils::battle::battle_utils::battle_result;

    fn get_monster(battle_id: usize, battles_won: u16) -> Monster {
        // let monster_id = battles_won % 7;
        let monster_id = 0;

        return Monster {
            battle_id,
            monster_id,
            attack: 8,
            health: 75,
            enrage_turn: 10,
            taunted_by: 0,
            minions_attack: 0
        };
    }

    fn monster_attack(world: IWorldDispatcher, ref battle: Battle, ref monster: Monster) {
        if monster.taunted_by > 0 {
            let mut creature = get!(world, (monster.taunted_by, battle.id), Creature);

            if battle.turn >= monster.enrage_turn {
                battle.adventure_health -= (monster.attack - creature.health);
            }

            battle_result(world, ref battle, ref creature, ref monster);
        } else {
            battle.adventure_health -= monster.attack;
        }

        battle.adventure_health -= minions_attack;
    }
}