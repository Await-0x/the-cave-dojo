use array::ArrayTrait;

mod battle_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use thecave::utils::cards::card_utils;
    use thecave::utils::random;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard};
    use thecave::models::card::{Card};
    use thecave::constants::{CardTypes, START_ENERGY, MAX_ENERGY, MAX_BOARD, DRAW_AMOUNT};

    fn get_board(world: IWorldDispatcher, ref battle: Battle) -> (Array<Creature>, Array<u8>) {
        let mut board = ArrayTrait::<Creature>::new();
        let mut available_spots = ArrayTrait::<u8>::new();
        
        let mut i = 1;
        loop {
            if i > MAX_BOARD {
                break;
            }

            let creature = get!(world, (i, battle.id), Creature);

            if creature.id != 0 {
                board.append(creature);
            } else {
                available_spots.append(i);
            }

            i+=1;
        };

        (board, available_spots)
    }

    fn get_hand(world: IWorldDispatcher, ref battle: Battle) -> Array<HandCard> {
        let mut hand = ArrayTrait::<HandCard>::new();
        
        let mut i = 1;
        loop {
            if i > DRAW_AMOUNT {
                break;
            }

            let card = get!(world, (i, battle.id), HandCard);

            if card.id != 0 {
                hand.append(card);
            }

            i+=1;
        };

        hand
    }

    fn get_next_energy(round: u16) -> u8 {
        let mut energy = START_ENERGY.into() + round;

        if energy > MAX_ENERGY.into() {
            return MAX_ENERGY;
        }

        energy.try_into().unwrap()
    }

    fn increase_health(ref battle: Battle, amount: u8) {
        battle.adventurer_health += amount.into();
    }

    fn increase_energy(ref battle: Battle, amount: u8) {
        battle.adventurer_energy += amount;
    }

    fn draw_cards(world: IWorldDispatcher, ref battle: Battle, amount: u8) {
        let mut i = 0;

        loop {
            if i == amount {
                break;
            }

            draw_card(world, ref battle, i);

            i += 1;
        }
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

    fn draw_card(world: IWorldDispatcher, ref battle: Battle, number: u8) {
        let entropy = random::get_entropy(number);
        let deck_card: DeckCard = random::get_random_deck_card(world, entropy, battle);
        let card: Card = card_utils::get_card(deck_card.card_id);

        set!(world, (
            HandCard {
                id: 1,
                battle_id: battle.id,
                card_id: card.id,
                card_type: card.card_type,
                card_tag: card.card_tag,
                cost: card.cost,
                attack: card.attack,
                health: card.health
            }, 
        ));

        delete!(world, (deck_card));

        battle.deck_size -= 1;
        battle.hand_size += 1;
    }

    fn battle_result(world: IWorldDispatcher, ref battle: Battle, ref creature: Creature, ref monster: Monster) {
        if (monster.health <= creature.attack) {
            monster.health = 0;
        }
        else {
            monster.health -= creature.attack;
        }
        
        if creature.shield {
            creature.shield = false;
            set!(world, (creature));
        }
        else if creature.health <= monster.attack {
            discard_card(world, ref battle, creature.card_id);
            delete!(world, (creature));
        }
        else {
            creature.health -= monster.attack;
            set!(world, (creature));
        }
    }
}

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

        let mut card = hand_utils::get_hand_card(entity_id, ref hand);

        if card.cost > battle.adventurer_energy || card.card_type != CardTypes::CREATURE {
            return;
        }

        card.id = 0;
        battle.adventurer_energy -= card.cost;

        let mut creature = Creature {
            id: board_slot,
            battle_id: battle.id,
            card_id: card.card_id,
            card_tag: card.card_tag,
            attack: card.attack,
            health: card.health,
            shield: false,
            resting_round: battle.round
        };

        summon_utils::summon_effect(world, ref creature, ref battle, ref monster, ref board, ref hand, ref round_effects, ref global_effects);
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
    ) {
        let mut creature = get!(world, (entity_id, battle.id), Creature);

        if (creature.resting_round == battle.round || creature.attack < 1 || creature.health < 1) {
            return;
        }

        creature.resting_round = battle.round;

        battle_utils::battle_result(world, ref battle, ref creature, ref monster);
    }

    fn discard(
        world: IWorldDispatcher,
        entity_id: u8,
        ref battle: Battle,
        ref monster: Monster,
    ) {
        let card = get!(world, (entity_id, battle.id), HandCard);

        discard_utils::discard_effect(world, entity_id, card.card_id, ref battle, ref monster);

        battle_utils::discard_card(world, ref battle, card.card_id);

        delete!(world, (card));
    }
}