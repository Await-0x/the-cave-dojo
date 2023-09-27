use array::ArrayTrait;
use RealmsLastStand::constants::{card_id};
use RealmsLastStand::components::card::Card;

trait DraftTrait {
    fn get_draft_choices() => Array<Card>;
    fn get_card(id: u16) -> Card;
}

impl DraftImpl of DraftTrait {
    fn get_draft_choices() => {
        let mut cards = ArrayTrait::<Card>::new();

        cards.append(get_card(0))
        cards.append(get_card(1))
        cards.append(get_card(2))

        return cards
    }

    fn get_card(id: u16) -> Card {
        if id == card_id::Bear {
            return Card {
                id: card_id::Bear,
                cost: 6,
                attack: 6,
                health: 6
            }
        }
        
        else if id == card_id::Wolf {
            return Card {
                id: card_id::Wolf,
                cost: 6,
                attack: 6,
                health: 6
            }
        }
        
        else if id == card_id::Ghoul {
            return Card {
                id: card_id::Ghoul,
                cost: 6,
                attack: 6,
                health: 6
            }
        }
        
        else if id == card_id::Ranger {
            return Card {
                id: card_id::Ranger,
                cost: 6,
                attack: 6,
                health: 6
            }
        }
        
        else if id == card_id::Dragon {
            return Card {
                id: card_id::Dragon,
                cost: 6,
                attack: 6,
                health: 6
            }
        }
    }
}