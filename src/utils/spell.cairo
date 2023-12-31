mod spell_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::{
        battle::battle_utils,
        board::board_utils
    };
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard, Board, Hand, RoundEffects, GlobalEffects};
    use thecave::constants::{CardTypes, ADVENTURER_ID};

    fn spell_effect(
        world: IWorldDispatcher,
        spell: HandCard,
        target_id: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref hand: Hand,
        ref board: Board,
        ref round_effects: RoundEffects,
        ref global_effects: GlobalEffects
    ) {
        if spell.card_id == 1 {
            if target_id == monster.monster_id {
                battle_utils::damage_monster(ref monster, 5);
            } else if target_id == ADVENTURER_ID {
                battle_utils::self_damage_adventurer(world, ref battle, 5, ref monster, ref hand, ref board, ref round_effects);
            } else {
                let mut creature = board_utils::get_creature_by_id(ref board, target_id.try_into().unwrap());

                if creature.health <= 5 {
                    battle_utils::creature_dead(world, ref battle, ref creature, ref board, ref round_effects, ref global_effects);
                } else {
                    creature.health -= 5;
                }

                board_utils::update_creature(ref board, ref creature);
            }
        }

        else if spell.card_id == 67 {
            battle_utils::damage_monster(ref monster, 3);
        }
    }
}