mod hand_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::{
        battle::battle_utils,
        board::board_utils
    };
    use thecave::models::battle::{Battle, HandCard, Monster, DeckCard, Hand, Board, RoundEffects, GlobalEffects};
    use thecave::constants::{CardTypes, CardTags, DECK_SIZE};

    fn load_hand(world: IWorldDispatcher, battle_id: usize) -> Hand {
        Hand {
            hand1: get!(world, (1, battle_id), HandCard),
            hand2: get!(world, (2, battle_id), HandCard),
            hand3: get!(world, (3, battle_id), HandCard),
            hand4: get!(world, (4, battle_id), HandCard),
            hand5: get!(world, (5, battle_id), HandCard),
            hand6: get!(world, (6, battle_id), HandCard),
        }
    }

    fn set_hand(world: IWorldDispatcher, ref hand: Hand) {
        if hand.hand1.card_id != 0 {
            set!(world, (hand.hand1));
        }
        if hand.hand2.card_id != 0 {
            set!(world, (hand.hand2));
        }
        if hand.hand3.card_id != 0 {
            set!(world, (hand.hand3));
        }
        if hand.hand4.card_id != 0 {
            set!(world, (hand.hand4));
        }
        if hand.hand5.card_id != 0 {
            set!(world, (hand.hand5));
        }
        if hand.hand6.card_id != 0 {
            set!(world, (hand.hand6));
        }
    }

    fn no_card() -> HandCard {
        HandCard {
            id: 0,
            battle_id: 0,
            card_id: 0,
            card_type: '',
            card_tag: '',
            cost: 0,
            attack: 0,
            health: 0
        }
    }

    fn get_hand_card(id: u8, ref hand: Hand) -> HandCard {
        if id == 1 {
            return hand.hand1;
        }

        else if id == 2 {
            return hand.hand2;
        }

        else if id == 3 {
            return hand.hand3;
        }

        else if id == 4 {
            return hand.hand4;
        }

        else if id == 5 {
            return hand.hand5;
        }
        
        else if id == 6 {
            return hand.hand6;
        }

        no_card()
    }

    fn remove_hand_card(id: u8, ref hand: Hand) {
        if id == 1 {
            hand.hand1.card_id = 0;
        }

        else if id == 2 {
            hand.hand2.card_id = 0;
        }

        else if id == 3 {
            hand.hand3.card_id = 0;
        }

        else if id == 4 {
            hand.hand4.card_id = 0;
        }

        else if id == 5 {
            hand.hand5.card_id = 0;
        }
        
        else if id == 6 {
            hand.hand6.card_id = 0;
        }
    }

    fn get_next_card(world: IWorldDispatcher, ref battle: Battle, hand_slot: u8, ref global_effects: GlobalEffects) -> HandCard {
        if battle.deck_size == 0 {
            battle_utils::switch_deck(world, ref battle, ref global_effects);
        }

        let card: DeckCard = get!(world, (battle.id, battle.deck_number, battle.deck_index), DeckCard);
        battle.deck_size -= 1;

        HandCard {
            id: hand_slot,
            battle_id: battle.id,
            card_id: card.card_id,
            card_type: card.card_type,
            card_tag: card.card_tag,
            cost: card.cost,
            attack: card.attack,
            health: card.health
        }
    }

    fn draw_cards(world: IWorldDispatcher, ref hand: Hand, ref battle: Battle, ref global_effects: GlobalEffects) {
        if hand.hand1.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 1, ref global_effects)));
        }
        
        if hand.hand2.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 2, ref global_effects)));
        }

        if hand.hand3.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 3, ref global_effects)));
        }

        if hand.hand4.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 4, ref global_effects)));
        }

        if hand.hand5.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 5, ref global_effects)));
        }

        if hand.hand6.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 6, ref global_effects)));
        }
    }

    fn reduce_cost(ref hand: Hand, card_id: u16, cost: u8) {
        if hand.hand1.card_id == card_id {
            hand.hand1.cost -= cost;
        }

        if hand.hand2.card_id == card_id {
            hand.hand2.cost -= cost;
        }

        if hand.hand3.card_id == card_id {
            hand.hand3.cost -= cost;
        }

        if hand.hand4.card_id == card_id {
            hand.hand4.cost -= cost;
        }

        if hand.hand5.card_id == card_id {
            hand.hand5.cost -= cost;
        }

        if hand.hand6.card_id == card_id {
            hand.hand6.cost -= cost;
        }
    }

    fn get_creature_cost(ref hand_card: HandCard, ref board: Board, ref round_effects: RoundEffects) -> u8 {
        let mut cost = hand_card.cost;

        let creature_3 = board_utils::count_card_id(ref board, 3);
        if creature_3 * round_effects.creatures_discarded >= cost {
            return 0;
        }
        cost -= creature_3 * round_effects.creatures_discarded;

        if hand_card.card_id == 34 {
            let scavengers = board_utils::count_type(ref board, CardTags::SCAVENGER);
            if scavengers >= cost {
                return 0;
            }

            cost -= scavengers;
        }

        if hand_card.card_id == 66 {
            let demons = board_utils::count_type(ref board, CardTags::DEMON);
            if demons >= cost {
                return 0;
            }

            cost -= demons;
        }

        if round_effects.adventurer_damaged == true {
            if round_effects.creature_reduction_if_damaged >= cost {
                return 0;
            }

            cost -= round_effects.creature_reduction_if_damaged;
        }
        
        if round_effects.adventurer_healed == true {
            if round_effects.creature_reduction_if_healed >= cost {
                return 0;
            }

            cost -= round_effects.creature_reduction_if_healed;
        }

        return cost;
    }

    fn get_spell_cost(ref hand_card: HandCard, ref round_effects: RoundEffects) -> u8 {
        let mut cost = hand_card.cost;

        if round_effects.spell_reduction >= cost {
            return 0;
        }

        cost -= round_effects.spell_reduction;

        if round_effects.adventurer_damaged == true {
            if round_effects.spell_reduction_if_damaged >= cost {
                return 0;
            }

            cost -= round_effects.spell_reduction_if_damaged;
        }
        
        if round_effects.adventurer_healed == true {
            if round_effects.spell_reduction_if_healed >= cost {
                return 0;
            }

            cost -= round_effects.spell_reduction_if_healed;
        }

        return cost;
    }
}