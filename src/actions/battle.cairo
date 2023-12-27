use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use starknet::{ContractAddress, ClassHash};
use array::ArrayTrait;

#[starknet::interface]
trait Ibattle_actions<TContractState> {
    fn end_turn(self: @TContractState, battle_id: usize, player_actions: Span<Span<felt252>>);
}

#[dojo::contract]
mod battle_actions {
    use starknet::{ContractAddress, get_caller_address};
    use super::Ibattle_actions;
    use thecave::models::{
        game::Game,
        battle::{Battle, Monster, RoundEffects, GlobalEffects},
    };
    use thecave::utils::battle::{
        battle_actions::{summon_creature, cast_spell, attack_monster, discard},
        battle_utils::{get_next_energy},
    };
    use thecave::utils::{
        monsters::monster_utils,
        board::board_utils,
        hand::hand_utils
    };
    use thecave::constants::{Messages, START_ENERGY, DRAW_AMOUNT};

    #[external(v0)]
    impl battle_actionsImpl of Ibattle_actions<ContractState> {
        fn end_turn(self: @ContractState, battle_id: usize, player_actions: Span<Span<felt252>>) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            let mut battle = get!(world, (battle_id), Battle); 
            let mut game = get!(world, (battle.game_id), Game);

            assert(battle.adventurer_health > 0, Messages::GAME_OVER);
            assert(game.player == player, Messages::NOT_OWNER);
            assert(game.active == true, Messages::NOT_IN_DRAFT);

            let mut monster = get!(world, (battle.id), Monster);
            assert(monster.health > 0, Messages::GAME_OVER);

            let mut round_effects = RoundEffects {
                adventurer_damaged: false,
                adventurer_healed: false,
                creature_reduction_if_healed: 0,
                creature_reduction_if_damaged: 0,
                spell_reduction_if_damaged: 0,
                creatures_discarded: 0,
                spell_reduction: 0
            };
            let mut global_effects = get!(world, (battle.id), GlobalEffects);
            
            let mut board = board_utils::load_board(world, battle.id);
            let mut hand = hand_utils::load_hand(world, battle.id);

            let action_count = player_actions.len();
            let mut action_index = 0;

            // Perform player actions
            loop {
                if action_index >= action_count {
                    break;
                }

                let action = *player_actions.at(action_index);

                let action_type: felt252 = *action.at(0);
                let entity_id: u8 = (*action.at(1)).try_into().unwrap();
                let target_id: u16 = (*action.at(2)).try_into().unwrap();

                if action_type == 'summon_creature' {
                    summon_creature(world, entity_id, ref battle, ref monster, ref board, ref hand, ref round_effects, ref global_effects);
                }
                else if action_type == 'cast_spell' {
                    cast_spell(world, entity_id, target_id, ref battle, ref monster);
                }
                else if action_type == 'attack_monster' {
                    attack_monster(world, entity_id, ref battle, ref monster, ref board, ref round_effects, ref global_effects);
                }
                else if action_type == 'discard' {
                    discard(world, entity_id, ref battle, ref monster, ref hand, ref board, ref round_effects);
                }
                else {
                    panic(array!['Unknown move']);
                }

                action_index += 1;
            };

            if monster.health < 1 {
                game.in_battle = false;
                game.battles_won += 1;

                set!(world, (game, monster));
                return;
            }

            monster.attack += 1;
            monster_utils::monster_attack(world, ref battle, ref monster, ref board, ref round_effects, ref global_effects);

            if battle.adventurer_health < 1 {
                game.active = false;
                game.in_battle = false;

                set!(world, (game, battle, monster));
                return;
            }

            board_utils::set_board(world, ref board);

            battle.adventurer_energy = get_next_energy(battle.round);
            battle.round += 1;

            hand_utils::set_hand(world, ref hand);
            hand_utils::draw_cards(world, ref hand, ref battle);

            set!(world, (battle, monster));
        }
    }
}