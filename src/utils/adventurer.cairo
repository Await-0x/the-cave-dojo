mod adventurer_utils {
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

    fn self_damage_effect(
        world: IWorldDispatcher,
        amount: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref board: Board,
        ref hand: Hand,
        ref round_effects: RoundEffects
    ) {
        board_utils::increase_creature_stats(ref board, 35, 1, 1);

        if round_effects.adventurer_damaged == false {
            round_effects.adventurer_damaged = true;
            round_effects.creature_reduction_if_damaged += board_utils::count_card_id(ref board, 36);
            round_effects.spell_reduction_if_damaged += board_utils::count_card_id(ref board, 40);
        }

        board_utils::increase_creature_stats(ref board, 37, 2, 0);

        hand_utils::reduce_cost(ref hand, 38, 1);

        hand_utils::reduce_cost(ref hand, 39, 1);

        battle_utils::damage_monster(ref monster, board_utils::count_card_id(ref board, 39).into() * amount);

        board_utils::increase_creature_stats(ref board, 41, 0, 2);

        battle_utils::increase_energy(ref battle, board_utils::count_card_id(ref board, 42));

        let creature_id_43 = board_utils::get_creature_by_card_id(ref board, 43);
        if creature_id_43.card_id != 0 {
            monster.taunted = true;
            monster.taunted_by = creature_id_43.id;
        }

        board_utils::apply_charge(ref board, 45);
    }

    fn heal_effect(
        world: IWorldDispatcher,
        amount: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref board: Board,
        ref hand: Hand,
        ref round_effects: RoundEffects
    ) {
        board_utils::increase_creature_stats(ref board, 68, 1, 1);

        if round_effects.adventurer_healed == false {
            round_effects.adventurer_healed = true;
            round_effects.creature_reduction_if_healed += board_utils::count_card_id(ref board, 69);
            round_effects.spell_reduction_if_healed += board_utils::count_card_id(ref board, 73);
        }

        board_utils::increase_creature_stats(ref board, 70, 2, 0);

        battle_utils::damage_monster(ref monster, board_utils::count_card_id(ref board, 72).into() * amount);
    }
}