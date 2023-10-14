mod CardUtils {
    use array::ArrayTrait;
    use DragonsNest::components::card::{Card};
    use DragonsNest::constants::{CardTypes,CardTags};

    fn get_card(id: u16) -> Card {
        if id == 1 {
            return Card {
                id: 1,
                name: 'Bear',
                card_type: CardTypes::CREATURE,
                cost: 6,
                attack: 6,
                health: 6,
                tag: CardTags::BEAST
            };
        }
        
        else if id == 2 {
            return Card {
                id: 2,
                name: 'Wolf',
                card_type: CardTypes::CREATURE,
                cost: 6,
                attack: 6,
                health: 6,
                tag: CardTags::BEAST
            };
        }
        
        else if id == 3 {
            return Card {
                id: 3,
                name: 'Ghoul',
                card_type: CardTypes::CREATURE,
                cost: 6,
                attack: 6,
                health: 6,
                tag: CardTags::UNDEAD
            };
        }
        
        else if id == 4 {
            return Card {
                id: 4,
                name: 'Ranger',
                card_type: CardTypes::CREATURE,
                cost: 6,
                attack: 6,
                health: 6,
                tag: CardTags::HUMAN
            };
        }
        
        else if id == 5 {
            return Card {
                id: 5,
                name: 'SkyRinger',
                card_type: CardTypes::CREATURE,
                cost: 6,
                attack: 6,
                health: 6,
                tag: CardTags::BEAST
            };
        }

        else {
            return Card {
                id: 0,
                name: 'Unknown',
                card_type: CardTypes::CREATURE,
                cost: 0,
                attack: 0,
                health: 0,
                tag: CardTags::BEAST
            };
        }
    }
}