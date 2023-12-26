mod board_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::battle::battle_utils;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard, Board};
    use thecave::constants::{CardTypes};

    fn load_board(world: IWorldDispatcher, battle_id: usize) -> Board {
        Board {
            creature1: get!(world, (1, battle_id), Creature),
            creature2: get!(world, (2, battle_id), Creature),
            creature3: get!(world, (3, battle_id), Creature),
            creature4: get!(world, (4, battle_id), Creature),
            creature5: get!(world, (5, battle_id), Creature),
            creature6: get!(world, (6, battle_id), Creature),
        }
    }

    fn set_board(world: IWorldDispatcher, ref board: Board) {
        if board.creature1.card_id != 0 {
            set!(world, (board.creature1));
        }
        if board.creature2.card_id != 0 {
            set!(world, (board.creature2));
        }
        if board.creature3.card_id != 0 {
            set!(world, (board.creature3));
        }
        if board.creature4.card_id != 0 {
            set!(world, (board.creature4));
        }
        if board.creature5.card_id != 0 {
            set!(world, (board.creature5));
        }
        if board.creature6.card_id != 0 {
            set!(world, (board.creature6));
        }
    }

    fn no_creature() -> Creature {
        Creature {
            id: 0,
            battle_id: 0,
            card_id: 0,
            card_tag: '',
            attack: 0,
            health: 0,
            shield: false,
            resting_round: 0,
        }
    }

    fn get_creature_by_id(ref board: Board, id: u8) -> Creature {
        if id == 1 {
            return board.creature1;
        } else if id == 2 {
            return board.creature2;
        } else if id == 3 {
            return board.creature3;
        } else if id == 4 {
            return board.creature4;
        } else if id == 5 {
            return board.creature5;
        } else if id == 6 {
            return board.creature6;
        }

        no_creature()
    }

    fn count_card_id(ref board: Board, card_id: u16) -> u8 {
        let mut count = 0;

        if board.creature1.card_id == card_id {
            count += 1;
        }

        if board.creature2.card_id == card_id {
            count += 1;
        }

        if board.creature3.card_id == card_id {
            count += 1;
        }

        if board.creature4.card_id == card_id {
            count += 1;
        }

        if board.creature5.card_id == card_id {
            count += 1;
        }

        if board.creature6.card_id == card_id {
            count += 1;
        }

        return count;
    }

    fn get_board_slot(ref board: Board) -> u8 {
        if board.creature1.card_id == 0 {
            return 1;
        }
        
        else if board.creature2.card_id == 0 {
            return 2;
        }

        else if board.creature3.card_id == 0 {
            return 3;
        }

        else if board.creature4.card_id == 0 {
            return 4;
        }

        else if board.creature5.card_id == 0 {
            return 5;
        }

        else if board.creature6.card_id == 0 {
            return 6;
        }

        return 0;
    }

    fn update_creature(ref board: Board, slot: u8, ref creature: Creature) {
        if slot == 1 {
            board.creature1 = creature;
        }

        else if slot == 2 {
            board.creature2 = creature;
        }

        else if slot == 3 {
            board.creature3 = creature;
        }

        else if slot == 4 {
            board.creature4 = creature;
        }

        else if slot == 5 {
            board.creature5 = creature;
        }

        else if slot == 6 {
            board.creature6 = creature;
        }
    }

    fn count_type(ref board: Board, _type: felt252) -> u16 {
        let mut count = 0;

        if board.creature1.card_tag == _type {
            count += 1;
        }

        if board.creature2.card_tag == _type {
            count += 1;
        }

        if board.creature3.card_tag == _type {
            count += 1;
        }

        if board.creature4.card_tag == _type {
            count += 1;
        }

        if board.creature5.card_tag == _type {
            count += 1;
        }

        if board.creature6.card_tag == _type {
            count += 1;
        }

        return count;
    }

    fn increase_type_stats(ref board: Board, _type: felt252, attack: u16, health: u16) {
        if board.creature1.card_tag == _type {
            board.creature1.attack += attack;
            board.creature1.health += health;
        }

        if board.creature2.card_tag == _type {
            board.creature2.attack += attack;
            board.creature2.health += health;
        }
        
        if board.creature3.card_tag == _type {
            board.creature3.attack += attack;
            board.creature3.health += health;
        }

        if board.creature4.card_tag == _type {
            board.creature4.attack += attack;
            board.creature4.health += health;
        }

        if board.creature5.card_tag == _type {
            board.creature5.attack += attack;
            board.creature5.health += health;
        }

        if board.creature6.card_tag == _type {
            board.creature6.attack += attack;
            board.creature6.health += health;
        }
    }

    fn decrease_type_stats(ref board: Board, _type: felt252, attack: u16, health: u16) {
        if board.creature1.card_tag == _type {
            board.creature1.attack -= attack;
            board.creature1.health -= health;
        }

        if board.creature2.card_tag == _type {
            board.creature2.attack -= attack;
            board.creature2.health -= health;
        }

        if board.creature3.card_tag == _type {
            board.creature3.attack -= attack;
            board.creature3.health -= health;
        }

        if board.creature4.card_tag == _type {
            board.creature4.attack -= attack;
            board.creature4.health -= health;
        }

        if board.creature5.card_tag == _type {
            board.creature5.attack -= attack;
            board.creature5.health -= health;
        }

        if board.creature6.card_tag == _type {
            board.creature6.attack -= attack;
            board.creature6.health -= health;
        }
    }

    fn increase_creature_stats(ref board: Board, attack: u16, health: u16) {
        if board.creature1.card_id != 0 {
            board.creature1.attack += attack;
            board.creature1.health += health;
        }

        if board.creature2.card_id != 0 {
            board.creature2.attack += attack;
            board.creature2.health += health;
        }

        if board.creature3.card_id != 0 {
            board.creature3.attack += attack;
            board.creature3.health += health;
        }

        if board.creature4.card_id != 0 {
            board.creature4.attack += attack;
            board.creature4.health += health;
        }

        if board.creature5.card_id != 0 {
            board.creature5.attack += attack;
            board.creature5.health += health;
        }

        if board.creature6.card_id != 0 {
            board.creature6.attack += attack;
            board.creature6.health += health;
        }
    }
}

#[cfg(test)]
mod tests {
    use debug::PrintTrait;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use core::traits::Into;
    use core::integer::{
        u8_overflowing_add, u16_overflowing_add, u16_overflowing_sub, U128IntoU256,
        u256_try_as_non_zero, u16_sqrt
    };
    use dojo::world::IWorldDispatcherTrait;
    use core::array::SpanTrait;
    use thecave::models::battle::{Creature, Board};

    #[test]
    #[available_gas(10000000)]
    fn test_reference() {
        let mut creature: Creature = Creature {
            id: 1,
            battle_id: 2,
            card_id: 1,
            card_tag: 'felt252',
            attack: 2,
            health: 2,
            shield: true,
            resting_round: 2,
        };

        let mut board = Board {
            creature1: creature,
            creature2: creature
        };

        board.creature1.attack += 2;
    }
}