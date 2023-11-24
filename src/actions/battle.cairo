use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use starknet::{ContractAddress, ClassHash};
use array::ArrayTrait;

#[starknet::interface]
trait Ibattle_actions<TContractState> {
    fn end_turn(self: @TContractState);
}

#[dojo::contract]
mod battle_actions {
    use starknet::{ContractAddress, get_caller_address};
    use super::Ibattle_actions;
    use thecave::models::{
        game::Game,
        battle::{Battle, Monster, SpecialEffects},
    };
    use thecave::utils::battle::{
        battle_actions::{summon_creature, cast_spell, attack_monster, attack_minion, discard},
        battle_utils::{monster_attack, draw_cards, get_next_energy},
    };
    use thecave::utils::monster::monster_utils;
    use thecave::constants::{Messages, ENERGY, DRAW_AMOUNT};

    #[external(v0)]
    impl battle_actionsImpl of Ibattle_actions<ContractState> {
        fn end_turn(self: @ContractState, battle_id: usize, player_actions: Array<Tuple<(felt252, usize, usize)>>) {
            let world = self.world_dispatcher.read();
            let player = get_caller_address();

            let mut battle = get!(world, (battle_id), Battle); 
            let mut game = get!(world, (battle.game_id) Game);

            assert(battle.adventure_health > 0, Messages::GAME_OVER);
            assert(game.player == player, Messages::NOT_OWNER);
            assert(game.active == true, Messages::NOT_IN_DRAFT);

            let mut monster = get!(world, (battle.id), Monster);
            assert(monster.health > 0, Messages::GAME_OVER);

            let mut special_effects = get!(world, (battle.id), SpecialEffects);

            let action_count = player_actions.len();
            let mut action_index = 0;

            // Perform player actions
            loop {
                if action_index >= action_count {
                    break;
                }

                let (action_type, entity, target) = *player_actions.at(action_index);

                match action_type {
                    'summon_creature' => { 
                        summon_creature(world, entity, ref battle, ref monster, ref special_effects);
                    },
                    'cast_spell' => {
                        cast_spell(world, entity, target, ref battle, ref special_effects);
                    },
                    'attack_monster' => {
                        attack_monster(world, entity, ref battle, ref monster, ref special_effects);
                    },
                    'attack_minion' => {
                        attack_minion(world, entity, target, ref battle, ref special_effects);
                    },
                    'discard' => {
                        discard(world, entity, ref battle, ref monster, ref special_effects);
                    },
                    _ => panic(array!['Unknown move']),
                }
            }

            if monster.health < 1 {
                game.in_battle = false;
                game.battles_won += 1;

                monster.health = 0;

                set!(world, (game, monster));
                return;
            }

            monster_utils::monster_attack(world, ref battle, ref monster);

            if battle.adventure_health < 1 {
                game.active = false;
                game.in_battle = false;

                set!(world, (game, battle));
                return;
            }

            draw_cards(world, ref battle, DRAW_AMOUNT - battle.hand_size);

            battle.adventure_energy = get_next_energy(battle.round);
            battle.round += 1;

            set!(world, (battle, monster, special_effects));
        }
    }
}