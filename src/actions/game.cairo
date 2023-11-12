use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use starknet::{ContractAddress, ClassHash};
use array::ArrayTrait;

#[starknet::interface]
trait IGameActions<TContractState> {
    fn start_draft(self: @TContractState);
}

#[dojo::contract]
mod game_actions {
    use starknet::{ContractAddress, get_caller_address};
    use super::IGameActions;

    use thecave::models::game::Game;
    use thecave::models::draft::{Draft, DraftOption};
    use thecave::utils::draft::DraftUtils::{get_draft_option};

    #[external(v0)]
    impl GameActionsImpl of IGameActions<ContractState> {
        fn start_draft(self: @ContractState) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            let game_id = world.uuid();
            let card_count = 0;

            set!(world, (
                Game { id: game_id, player: player, active: true, in_draft: true, in_battle: false, battles_won: 0, entropy: 0 },
                Draft { game_id, card_count: 0 }
            ));

            set!(world, (
                get_draft_option(game_id, 0, 1),
                get_draft_option(game_id, 1, 2),
                get_draft_option(game_id, 2, 3),
            ));
        }

        fn start_battle(self: @ContractState, game_id: usize) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();
            
            let game = get!(world, (battle.game_id) Game);

            let card_count = 0;
            set!(world, (
                
            ))
        }
    }
}