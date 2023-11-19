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
    use thecave::models::card::Card;
    use thecave::models::draft::{Draft, DraftCard, DraftOption};
    use thecave::models::battle::{Battle, HandCard, DeckCard, SpecialEffects};
    use thecave::utils::cards::card_utils::{get_card};
    use thecave::utils::monsters::monster_utils::{get_monster};
    use thecave::utils::draft::draft_utils::{get_draft_options};
    use thecave::constants::{Messages, DECK_SIZE, DRAW_AMOUNT, START_HEALTH, ENERGY};
    use thecave::utils::random::shuffle_deck;

    #[external(v0)]
    impl GameActionsImpl of IGameActions<ContractState> {
        fn start_draft(self: @ContractState) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            let game_id = world.uuid();
            let card_count = 0;

            set!(world, (
                Game { id: game_id, player: player, active: true, in_draft: true, in_battle: false, battles_won: 0 },
                Draft { game_id, card_count: 0 }
            ));

            let (option_1, option_2, option_3) = get_draft_options(game_id, player); 
            set!(world, (option_1, option_2, option_3));
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
                    adventure_health: START_HEALTH,
                    adventure_energy: ENERGY,
                    round: 1,
                    deck_index: DRAW_AMOUNT.into(),
                    deck_size: (DECK_SIZE - DRAW_AMOUNT).into(),
                    board_count: 0,
                    hand_total: 5,
                    vortex_count: 0,
                },
                SpecialEffects {
                    battle_id,
                    sleep: true,
                    vortex_limit: 1,
                    draw_from_vortex: false,
                    vortex_draw: false,
                    vortex_energy: false,
                    vortex_hand: false,
                    draw_extra_life_cost: false
                }
            ));

            let monster = get_monster(battle_id, game.battles_won);
            set!(world, (monster));

            let shuffled_deck = shuffle_deck(1, DECK_SIZE);
            
            let mut i = 0;
            loop {
                if i >= shuffled_deck.len() {
                    break;
                }

                let draft_card: DraftCard = get!(world, (game_id, *shuffled_deck.at(i)), DraftCard);
                let card: Card = get_card(draft_card.card_id);

                if i < DRAW_AMOUNT.into() {
                    set!(world, (
                        HandCard {
                            id: i.try_into().unwrap(),
                            battle_id,
                            card_id: card.id,
                            card_type: card.card_type,
                            cost: card.cost,
                            attack: card.attack,
                            health: card.health
                        }, 
                    ));
                } else {
                    set!(world, (
                        DeckCard {
                            battle_id,
                            number: i.try_into().unwrap(),
                            card_id: card.id,
                            card_type: card.card_type,
                            cost: card.cost,
                            attack: card.attack,
                            health: card.health
                        },
                    ));
                }

                i += 1;
            };
        }
    }
}