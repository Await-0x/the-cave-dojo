use array::ArrayTrait;

mod battle_actions {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use thecave::utils::{
        summon::summon_utils,
        spell::spell_utils,
        discard::discard_utils,
        battle::battle_utils,
        hand::hand_utils,
        board::board_utils
    };
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, Minion, RoundEffects, GlobalEffects, Board, Hand};
    use thecave::constants::{CardTypes};

    fn summon_creature(
        world: IWorldDispatcher,
        entity_id: u8,
        ref battle: Battle,
        ref monster: Monster,
        ref board: Board,
        ref hand: Hand,
        ref round_effects: RoundEffects,
        ref global_effects: GlobalEffects
    ) {
        let board_slot = board_utils::get_board_slot(ref board);
        if board_slot == 0 {
            return;
        }

        let mut hand_card = hand_utils::get_hand_card(entity_id, ref hand);

        if hand_card.cost > battle.adventurer_energy || hand_card.card_type != CardTypes::CREATURE {
            return;
        }

        battle.adventurer_energy -= hand_card.cost;

        let mut creature = Creature {
            id: board_slot,
            battle_id: battle.id,
            card_id: hand_card.card_id,
            card_tag: hand_card.card_tag,
            attack: hand_card.attack,
            health: hand_card.health,
            shield: false,
            resting_round: battle.round
        };

        hand_utils::remove_hand_card(entity_id, ref hand);
        summon_utils::summon_effect(world, ref creature, ref battle, ref monster, ref board, ref hand, ref round_effects, ref global_effects);
        board_utils::update_creature(ref board, board_slot, ref creature);
    }

    fn cast_spell(
        world: IWorldDispatcher,
        entity_id: u8,
        target_id: u16,
        ref battle: Battle,
        ref monster: Monster,
    ) {
        let card = get!(world, (entity_id, battle.id), HandCard);
        let mut creature = get!(world, (target_id, battle.id), Creature);

        if card.cost > battle.adventurer_energy || card.card_type != CardTypes::SPELL {
            return;
        }

        battle.adventurer_energy -= card.cost;
        spell_utils::spell_effect(world, entity_id, card.card_id, ref battle, ref monster, ref creature);
    }

    fn attack_monster(
        world: IWorldDispatcher,
        entity_id: u8,
        ref battle: Battle,
        ref monster: Monster,
        ref board: Board
    ) {
        let mut creature = board_utils::get_creature_by_id(ref board, entity_id);

        if (creature.resting_round == battle.round || creature.attack < 1 || creature.health < 1) {
            return;
        }

        creature.resting_round = battle.round;

        battle_utils::battle_result(world, ref battle, ref creature, ref monster);
        board_utils::update_creature(ref board, creature.id, ref creature);
    }

    fn discard(
        world: IWorldDispatcher,
        entity_id: u8,
        ref battle: Battle,
        ref monster: Monster,
        ref hand: Hand,
    ) {
        let mut hand_card = hand_utils::get_hand_card(entity_id, ref hand);

        discard_utils::discard_effect(world, entity_id, hand_card.card_id, ref battle, ref monster);

        battle_utils::discard_card(world, ref battle, hand_card.card_id);

        hand_utils::remove_hand_card(entity_id, ref hand);
    }
}

mod battle_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use thecave::utils::cards::card_utils;
    use thecave::utils::random;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard};
    use thecave::models::card::{Card};
    use thecave::constants::{CardTypes, START_ENERGY, MAX_ENERGY, MAX_HEALTH, MAX_BOARD, DRAW_AMOUNT};

    fn self_damage_adventurer(ref battle: Battle, amount: u16) {
        if battle.adventurer_health < amount {
            battle.adventurer_health = 0;
        } else {
            battle.adventurer_health -= amount;
        }
    }

    fn heal_adventurer(ref battle: Battle, amount: u16) {
        if battle.adventurer_health == MAX_HEALTH {
            return;
        }

        if battle.adventurer_health + amount > MAX_HEALTH {
            battle.adventurer_health = MAX_HEALTH;
        } else {
            battle.adventurer_health += amount;
        }
    }

    fn get_next_energy(round: u16) -> u8 {
        let mut energy = START_ENERGY.into() + round;

        if energy > MAX_ENERGY.into() {
            return MAX_ENERGY;
        }

        energy.try_into().unwrap()
    }

    fn increase_energy(ref battle: Battle, amount: u8) {
        battle.adventurer_energy += amount;
    }

    fn discard_card(world: IWorldDispatcher, ref battle: Battle, card_id: u16) {
        let card = card_utils::get_card(card_id);

        set!(world, (
            DeckCard {
                battle_id: battle.id,
                card_number: battle.discard_count,
                deck_number: battle.deck_number + 1,
                card_id: card.id,
                card_type: card.card_type,
                card_tag: card.card_tag,
                cost: card.cost,
                attack: card.attack,
                health: card.health
            }
        ));

        battle.discard_count += 1;
    }

    fn battle_result(world: IWorldDispatcher, ref battle: Battle, ref creature: Creature, ref monster: Monster) {
        if monster.health <= creature.attack {
            monster.health = 0;
        } else {
            monster.health -= creature.attack;
        }

        if creature.shield {
            if monster.attack > 0 {
                creature.shield = false;
            }
        } else if creature.health <= monster.attack {
            creature_dead(ref battle, ref creature);
        } else {
            creature.health -= monster.attack;
        }
    }

    fn creature_dead(ref battle: Battle, ref creature: Creature) {
        creature.card_id = 0;
        creature.health = 0;
        battle.discard_count += 1;
    } 
}