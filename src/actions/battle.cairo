use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use starknet::{ContractAddress, ClassHash};
use array::ArrayTrait;

#[starknet::interface]
trait IBattleActions<TContractState> {
    fn end_turn(self: @TContractState);
}

#[dojo::contract]
mod battle_actions {
    use starknet::{ContractAddress, get_caller_address};
    use super::IBattleActions;

    use thecave::models::battle::{Battle};
    use thecave::models::game::Game;
    use thecave::models::draft::{Draft, DraftOption};
    use thecave::utils::draft::DraftUtils::{get_draft_option};

    #[external(v0)]
    impl BattleActionsImpl of IBattleActions<ContractState> {
        fn end_turn(self: @ContractState, battle_id: usize, moves: Array<Tuple<(felt252, usize, usize)>>) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            let battle = get!(world, (battle_id), Battle); 
            let game = get!(world, (battle.game_id) Game);

            assert(battle.adventure_health > 0, Messages::GAME_OVER);
            assert(game.player == player, Messages::NOT_OWNER);
            assert(game.active == true, Messages::NOT_IN_DRAFT);

            let move_count = moves.len();
            let mut move_index = 0;

            // Perform player moves
            loop {
                if move_index >= move_count {
                    break;
                }

                let move = *moves.at(move_index)

                match *move.at(0) {
                    'summon_creature' => { 
                        true
                    },
                    'cast_spell' => {
                        true
                    },
                    'attack' => {
                        true
                    },
                    'vortex' => {
                        true
                    },
                    _ => panic(array!['Unknown move']),
                }
            }
        }
    }
}