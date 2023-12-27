mod death_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::{
        battle::battle_utils,
        board::board_utils,
        hand::hand_utils
    };
    use thecave::models::battle::{Battle, HandCard, Creature, DeckCard, Board, Hand, RoundEffects, GlobalEffects};
    use thecave::constants::{CardTypes, CardTags};

    fn death_effect(
        world: IWorldDispatcher,
        ref creature: Creature,
        ref battle: Battle,
        ref board: Board,
        ref round_effects: RoundEffects,
        ref global_effects: GlobalEffects
    ) {
        let id = creature.card_id;

        if id == 33 {
            board_utils::decrease_type_stats(ref board, CardTags::SCAVENGER, 2, 0);
        }

        else if id == 36 {
            if round_effects.adventurer_damaged == true {
                round_effects.creature_reduction_if_damaged -= 1;
            }
        }

         else if id == 40 {
            if round_effects.adventurer_damaged == true {
                round_effects.spell_reduction_if_damaged -= 1;
            }
        }

        else if id == 69 {
            if round_effects.adventurer_healed == true {
                round_effects.creature_reduction_if_damaged -= 1;
            }
        }

        else if id == 73 {
            if round_effects.adventurer_healed == true {
                round_effects.spell_reduction_if_damaged -= 1;
            }
        }
    }
}