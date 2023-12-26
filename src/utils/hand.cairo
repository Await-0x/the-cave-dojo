mod hand_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::battle::battle_utils;
    use thecave::models::battle::{Battle, HandCard, Monster, DeckCard, Hand};
    use thecave::constants::{CardTypes, DECK_SIZE};

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

    fn get_next_card(world: IWorldDispatcher, ref battle: Battle, hand_slot: u8) -> HandCard {
        if battle.deck_size == 0 {
            battle.deck_index = 0;
            battle.deck_number += 1;
            battle.deck_size = battle.discard_count;
            battle.discard_count = 0;
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

    fn draw_cards(world: IWorldDispatcher, ref hand: Hand, ref battle: Battle) {
        if hand.hand1.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 1)));
        }
        
        if hand.hand2.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 2)));
        }

        if hand.hand3.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 3)));
        }

        if hand.hand4.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 4)));
        }

        if hand.hand5.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 5)));
        }

        if hand.hand6.card_id == 0 {
            set!(world, (get_next_card(world, ref battle, 6)));
        }
    }
}