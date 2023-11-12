use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use starknet::{ContractAddress, ClassHash};
use array::ArrayTrait;

#[starknet::interface]
trait IDraftActions<TContractState> {
    fn pick_card(self: @TContractState, game_id: usize, option_id: u8);
}

#[dojo::contract]
mod draft_actions {
    use starknet::{ContractAddress, get_caller_address};
    use super::IDraftActions;
    use array::ArrayTrait;
    use debug::PrintTrait;

    use thecave::models::game::{Game};
    use thecave::models::draft::{Draft, DraftOption, DraftCard};
    use thecave::utils::draft::DraftUtils::{get_draft_option};
    use thecave::constants::Messages;

    #[external(v0)]
    impl DraftActionsImpl of IDraftActions<ContractState> {
        fn pick_card(self: @ContractState, game_id: usize, option_id: u8) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            let mut game = get!(world, (game_id), Game);

            assert(game.player == player, Messages::NOT_OWNER);
            assert(game.active == true, Messages::GAME_OVER);

            let mut choice = get!(world, (game_id, option_id), DraftOption);
            let mut draft = get!(world, (game_id), Draft);

            let card_count = draft.card_count + 1;

            set!(world, (
                Draft { game_id, card_count },
            ));

            set!(world, (
                DraftCard { game_id, card_id: choice.card_id, number: card_count },
            ));

            if card_count < 30 {
                set!(world, (
                    get_draft_option(game_id, 0, 1),
                    get_draft_option(game_id, 1, 2),
                    get_draft_option(game_id, 2, 3),
                ));
            } else {
                set!(world, (
                    Game { id: game_id, player: player, active: true, in_draft: false, in_battle: false, battles_won: 0, entropy: 0 },
                ));
            }
        }
    }
}
