mod MonsterUtils {
    use array::ArrayTrait;
    use thecave::models::battle::{Monster};

    fn get_monster(battle_id: usize, battles_won: u16) -> Monster {
        // let monster_id = battles_won % 7;
        let monster_id = 0;

        if monster_id == 0 {
            return Monster {
                battle_id,
                monster_id,
                attack: 8,
                health: 75
            };
        }
    }
}