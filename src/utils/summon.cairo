mod summon_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::{
        battle::battle_utils,
        board::board_utils,
        hand::hand_utils,
    };
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard, Board, Hand, RoundEffects, GlobalEffects};
    use thecave::constants::{CardTypes, CardTags};

    fn summon_effect(
        world: IWorldDispatcher,
        ref creature: Creature,
        ref battle: Battle,
        ref monster: Monster,
        ref board: Board,
        ref hand: Hand,
        ref round_effects: RoundEffects,
        ref global_effects: GlobalEffects
    ) {
        let id = creature.card_id;
    
        // Taunt
        if id == 14 || id == 15 || id == 16 || id == 17 || id == 18 || id == 19 || id == 49 || id == 50 || id == 51 || id == 82 || id == 83 || id == 84 || id == 85 {
            monster.taunted = true;
            monster.taunted_by = creature.id;
        }

        // Charge
        if id == 20 || id == 21 || id == 22 || id == 52 || id == 53 || id == 54 || id == 86 || id == 87 || id == 88 || id == 201 || id == 202 {
            creature.resting_round = 0;
        }

        // Shield
        if id == 23 || id == 24 || id == 25 || id == 55 || id == 56 || id == 57 || id == 89 || id == 90 || id == 91 {
            creature.shield = true;
        }

        if id == 31 {
            creature.attack += global_effects.scavengers_discarded.into();
            creature.health += global_effects.scavengers_discarded.into();
        }

        else if id == 32 {
            let scavenger_count = board_utils::count_type(ref board, CardTags::SCAVENGER);
            creature.attack += scavenger_count;
            creature.health += scavenger_count;
        }

        else if id == 33 {
            board_utils::increase_type_stats(ref board, CardTags::SCAVENGER, 2, 0);
        }

        else if id == 36 {
            if round_effects.adventurer_damaged == true {
                hand_utils::reduce_creature_cost(ref hand, 1);
            }
        }

        else if id == 47 {

        }

        else if id == 65 {

        }

        else if id == 80 {

        }

        else if id == 98 {

        }
    }
}