mod discard_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::{
        battle::battle_utils,
        board::board_utils,
        hand::hand_utils
    };
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard, Board, Hand, RoundEffects};
    use thecave::constants::{CardTypes};

    fn discard_effect(
        world: IWorldDispatcher,
        hand_card: HandCard,
        ref battle: Battle,
        ref monster: Monster,
        ref board: Board,
        ref hand: Hand,
        ref round_effects: RoundEffects
    ) {
        if hand_card.card_type == CardTypes::CREATURE {
            round_effects.creatures_discarded += 1;
        }

        board_utils::increase_creature_stats(ref board, 2, 1, 1);
        board_utils::increase_creature_stats(ref board, 4, 2, 0);
        hand_utils::reduce_cost(ref hand, 5, 1);
        battle_utils::damage_monster(ref monster, board_utils::count_card_id(ref board, 6).into());
        round_effects.spell_reduction += board_utils::count_card_id(ref board, 7);
        board_utils::increase_creature_stats(ref board, 8, 0, 2);
        battle_utils::increase_energy(ref battle, board_utils::count_card_id(ref board, 9));
        battle_utils::heal_adventurer(world, ref battle, board_utils::count_card_id(ref board, 10).into(), ref monster, ref hand, ref board, ref round_effects);

        let creature_id_11 = board_utils::get_creature_by_card_id(ref board, 11);
        if creature_id_11.card_id != 0 {
            monster.taunted = true;
            monster.taunted_by = creature_id_11.id;
        }

        board_utils::apply_shield(ref board, 12);
        board_utils::apply_charge(ref board, 13);
        battle_utils::self_damage_adventurer(world, ref battle, board_utils::count_card_id(ref board, 46).into(), ref monster, ref hand, ref board, ref round_effects);
        battle_utils::heal_adventurer(world, ref battle, board_utils::count_card_id(ref board, 79).into(), ref monster, ref hand, ref board, ref round_effects);
    }
}