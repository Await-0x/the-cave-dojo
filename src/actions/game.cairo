use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use starknet::{ContractAddress, ClassHash};
use array::ArrayTrait;

#[starknet::interface]
trait IGameActions<TContractState> {
    fn start_draft(self: @TContractState);
    fn start_battle(self: @TContractState, game_id: usize);
}

#[dojo::contract]
mod game_actions {
    use starknet::{ContractAddress, get_caller_address};
    use super::IGameActions;

    use thecave::models::game::Game;
    use thecave::models::draft::{Draft, DraftOption};
    use thecave::models::battle::{Battle, HandCard, DeckCard};
    use thecave::utils::cards::CardUtils::{get_card};
    use thecave::utils::monsters::MonsterUtils::{get_monster};
    use thecave::utils::draft::DraftUtils::{get_draft_options};
    use thecave::constants::{Messages, DECK_SIZE, DRAW_AMOUNT, START_HEALTH};
    use thecave::utils::random::shuffle_deck;

    #[external(v0)]
    impl GameActionsImpl of IGameActions<ContractState> {
        fn start_draft(self: @ContractState) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            let game_id = world.uuid();
            let card_count = 0;
            let entropy = 1;

            set!(world, (
                Game { id: game_id, player: player, active: true, in_draft: true, in_battle: false, battles_won: 0, entropy },
                Draft { game_id, card_count: 0 }
            ));

            set!(world, get_draft_options(game_id, entropy));
        }

        fn start_battle(self: @ContractState, game_id: usize) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();
            
            let game = get!(world, (game_id), Game);

            assert(game.player == player, Messages::NOT_OWNER);
            assert(game.active == true, Messages::GAME_OVER);
            assert(game.in_draft == false, Messages::IN_DRAFT);
            assert(game.in_battle == false, Messages::IN_BATTLE);

            let battle_id = world.uuid();

            set!(world, (
                Battle {
                    id: battle_id,
                    game_id,
                    active: true,
                    adventure_health: START_HEALTH,
                    round: 1,
                    board_count: 0,
                    hand_count: 5,
                    vortex_count: 0,
                    deck_index: DRAW_AMOUNT
                },
            ));

            let monster = get_monster(battle_id, game.battles_won);
            set!(world, (monster));

            let shuffled_deck = shuffle_deck(1, DECK_SIZE);
            
            let mut i = 0;
            loop {
                if i >= shuffled_deck.len() {
                    break;
                }

                let draft_card = get!(world, (game_id, *shuffled_deck.at(i)), DraftCard);
                let card = get_card(draft_card.card_id);

                if i < DRAW_AMOUNT {
                    set!(world, (
                        HandCard { id: i, battle_id, card_id: card.id, card_type: card.card_type, cost: card.cost, attack: card.attack, health: card.health }, 
                    ));
                } else {
                    set!(world, (
                        DeckCard { battle_id, number: i, card_type: card.card_type, cost: card.cost, attack: card.attack, health: card.health },
                    ));
                }

                i += 1;
            };
        }
    }
}