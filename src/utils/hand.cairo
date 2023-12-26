mod hand_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::battle::battle_utils;
    use thecave::models::battle::{Battle, HandCard, Monster, DeckCard, Hand};
    use thecave::constants::{CardTypes};

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

    fn reduce_creature_cost(ref hand: Hand, amount: u8) {
        if hand.hand1.id > 0 && hand.hand1.cost > 0 && hand.hand1.card_type == CardTypes::CREATURE {
            hand.hand1.cost -= amount;
        }

        if hand.hand2.id > 0 && hand.hand2.cost > 0 && hand.hand2.card_type == CardTypes::CREATURE {
            hand.hand2.cost -= amount;
        }

        if hand.hand3.id > 0 && hand.hand3.cost > 0 && hand.hand3.card_type == CardTypes::CREATURE {
            hand.hand3.cost -= amount;
        }

        if hand.hand4.id > 0 && hand.hand4.cost > 0 && hand.hand4.card_type == CardTypes::CREATURE {
            hand.hand4.cost -= amount;
        }

        if hand.hand5.id > 0 && hand.hand5.cost > 0 && hand.hand5.card_type == CardTypes::CREATURE {
            hand.hand5.cost -= amount;
        }

        if hand.hand6.id > 0 && hand.hand6.cost > 0 && hand.hand6.card_type == CardTypes::CREATURE {
            hand.hand6.cost -= amount;
        }
    }
}