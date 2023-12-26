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
    use thecave::models::battle::{Battle, HandCard, DeckCard, GlobalEffects};
    use thecave::utils::cards::card_utils::{get_card};
    use thecave::utils::monsters::monster_utils::{get_monster};
    use thecave::utils::draft::draft_utils::{get_draft_options};
    use thecave::constants::{Messages, DECK_SIZE, DRAW_AMOUNT, DISCARD_COST, START_HEALTH, START_ENERGY};
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

            let (option_1, option_2, option_3) = get_draft_options(game_id, 0); 
            set!(world, (option_1, option_2, option_3));
        }

        fn start_battle(self: @ContractState, game_id: usize) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();
            
            let mut game = get!(world, (game_id), Game);

            assert(game.player == player, Messages::NOT_OWNER);
            assert(game.active == true, Messages::GAME_OVER);
            assert(game.in_draft == false, Messages::IN_DRAFT);
            assert(game.in_battle == false, Messages::IN_BATTLE);

            let battle_id = world.uuid();

            set!(world, (
                Battle {
                    id: battle_id,
                    game_id,
                    adventurer_health: START_HEALTH,
                    adventurer_energy: START_ENERGY,
                    round: 1,
                    deck_size: (DECK_SIZE - DRAW_AMOUNT).into(),
                    hand_size: DRAW_AMOUNT,
                    deck_number: 1,
                    discard_count: 0,
                },
                GlobalEffects {
                    battle_id: battle_id,
                    scavenger_attack_bonus: 0,
                    priest_attack_bonus: 0,
                    demon_attack_bonus: 0,
                    scavengers_discarded: 0
                }
            ));

            let monster = get_monster(battle_id, game.battles_won);
            set!(world, (monster));

            let shuffled_deck = shuffle_deck(1, DECK_SIZE);
            
            let mut i: u8 = 0;
            loop {
                if i.into() >= shuffled_deck.len() {
                    break;
                }

                let draft_card: DraftCard = get!(world, (game_id, 1, *shuffled_deck.at(i.into())), DraftCard);
                let card: Card = get_card(draft_card.card_id);

                if i < DRAW_AMOUNT.into() {
                    set!(world, (
                        HandCard {
                            id: i + 1,
                            battle_id,
                            card_id: card.id,
                            card_type: card.card_type,
                            card_tag: card.card_tag,
                            cost: card.cost,
                            attack: card.attack,
                            health: card.health
                        }, 
                    ));
                } else {
                    set!(world, (
                        DeckCard {
                            battle_id,
                            card_number: i.try_into().unwrap(),
                            deck_number: 1,
                            card_id: card.id,
                            card_type: card.card_type,
                            card_tag: card.card_tag,
                            cost: card.cost,
                            attack: card.attack,
                            health: card.health
                        },
                    ));
                }

                i += 1;
            };

            game.in_battle = true;
            set!(world, (game));
        }
    }
}