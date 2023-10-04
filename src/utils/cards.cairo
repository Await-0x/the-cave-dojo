mod CardUtils {
    use array::ArrayTrait;
    use RealmsLastStand::components::card::Card;

    fn get_card(id: u16) -> Card {
        if id == 1 {
            return Card {
                id: 1,
                name: 'Bear',
                cost: 6,
                attack: 6,
                health: 6
            };
        }
        
        else if id == 2 {
            return Card {
                id: 2,
                name: 'Wolf',
                cost: 6,
                attack: 6,
                health: 6
            };
        }
        
        else if id == 3 {
            return Card {
                id: 3,
                name: 'Ghoul',
                cost: 6,
                attack: 6,
                health: 6
            };
        }
        
        else if id == 4 {
            return Card {
                id: 4,
                name: 'Ranger',
                cost: 6,
                attack: 6,
                health: 6
            };
        }
        
        else if id == 5 {
            return Card {
                id: 5,
                name: 'Dragon',
                cost: 6,
                attack: 6,
                health: 6
            };
        }

        else {
            return Card {
                id: 0,
                name: 'Unknown',
                cost: 0,
                attack: 0,
                health: 0
            };
        }
    }
}