use array::ArrayTrait;

mod battle_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use thecave::utils::cards::card_utils;
    use thecave::utils::random;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard};
    use thecave::models::card::{Card};
    use thecave::constants::{CardTypes, START_ENERGY, MAX_ENERGY};

    fn get_next_energy(round: u8) -> u8 {
        let mut energy = START_ENERGY + round;

        if energy > MAX_ENERGY {
            return MAX_ENERGY;
        }

        energy
    }

    fn increase_health(ref battle: Battle, amount: u8) {
        battle.adventure_health += amount.into();
    }

    fn increase_energy(ref battle: Battle, amount: u8) {
        battle.adventure_energy += amount;
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
                cost: card.cost,
                attack: card.attack,
                health: card.health
            }
        ));

        battle.discard_count += 1;
    }

    fn draw_card(world: IWorldDispatcher, ref battle: Battle, number: u8) {
        let entropy = random::get_entropy(number);
        let next_card: DeckCard = random::get_random_deck_card(world, entropy, battle);
        let card: Card = card_utils::get_card(next_card.card_id);

        set!(world, (
            HandCard {
                id: next_card.card_number,
                battle_id: battle.id,
                card_id: card.id,
                card_type: card.card_type,
                cost: card.cost,
                attack: card.attack,
                health: card.health
            }, 
        ));

        world.delete_entity('deck_card', array![battle.id.into(), next_card.card_number.into()].span());

        battle.deck_size -= 1;
        battle.hand_size += 1;
    }

    fn monster_attack(world: IWorldDispatcher, ref battle: Battle, ref monster: Monster) {
        if monster.taunted_by > 0 {
            let mut creature = get!(world, (monster.taunted_by, battle.id), Creature);
            battle_result(world, ref battle, ref creature, ref monster);
        } else {
            battle.adventure_health -= monster.attack;
        }
    }

    fn battle_result(world: IWorldDispatcher, ref battle: Battle, ref creature: Creature, ref monster: Monster) {
        monster.health -= creature.attack;
        
        if creature.health <= monster.attack {
            discard_card(world, ref battle, creature.card_id);
            world.delete_entity('Creature', array![creature.id.into(), battle.id.into()].span());
        } else {
            creature.health -= monster.attack;
            set!(world, (creature));
        }
    }
}

mod battle_actions {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use thecave::utils::creature::creature_utils;
    use thecave::utils::spell::spell_utils;
    use thecave::utils::attack::attack_utils;
    use thecave::utils::discard::discard_utils;
    use thecave::utils::battle::battle_utils::{battle_result, discard_card};
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, Minion, SpecialEffects};
    use thecave::constants::{CardTypes};

    fn summon_creature(
        world: IWorldDispatcher,
        entity_id: u8,
        ref battle: Battle,
        ref monster: Monster,
        ref special_effects: SpecialEffects
    ) {
        let card = get!(world, (entity_id, battle.id), HandCard);

        if card.cost > battle.adventure_energy || card.card_type != CardTypes::CREATURE {
            return;
        }

        world.delete_entity('hand_card', array![entity_id.into(), battle.id.into()].span());

        set!(world, ( Creature {
            id: card.id,
            battle_id: battle.id,
            card_id: card.card_id,
            attack: card.attack,
            health: card.health,
            resting: true
        } ));

        battle.adventure_energy -= card.cost;
        creature_utils::summon_effect(world, entity_id, card.card_id, ref battle, ref monster, ref special_effects);
    }

    fn cast_spell(
        world: IWorldDispatcher,
        entity_id: u16,
        target_id: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref special_effects: SpecialEffects
    ) {
        let card = get!(world, (entity_id, battle.id), HandCard);
        let mut creature = get!(world, (target_id, battle.id), Creature);

        if card.cost > battle.adventure_energy || card.card_type != CardTypes::SPELL {
            return;
        }

        battle.adventure_energy -= card.cost;
        spell_utils::spell_effect(world, entity_id, card.card_id, ref battle, ref monster, ref creature, ref special_effects);
    }

    fn attack_monster(
        world: IWorldDispatcher,
        entity_id: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref special_effects: SpecialEffects
    ) {
        let mut creature = get!(world, (entity_id, battle.id), Creature);
        
        attack_utils::attack_effect(world, entity_id, creature.card_id, ref battle, ref monster, ref creature, ref special_effects);
        battle_result(world, ref battle, ref creature, ref monster);
    }

    fn attack_minion(
        world: IWorldDispatcher,
        entity_id: u16,
        target_id: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref special_effects: SpecialEffects
    ) {
        let mut creature = get!(world, (entity_id, battle.id), Creature);
        let mut minion = get!(world, (battle.id, target_id), Minion);

        attack_utils::attack_effect(world, entity_id, creature.card_id, ref battle, ref monster, ref creature, ref special_effects);

        minion.health -= creature.attack;
        creature.health -= minion.attack;

        if creature.health <= 0 {
            discard_card(world, ref battle, creature.card_id);
            world.delete_entity('Creature', array![creature.id.into(), battle.id.into()].span());
        } else {
            set!(world, (creature));
        }

        if minion.health <= 0 {
            monster.minions_attack -= minion.attack;
            world.delete_entity('Minion', array![battle.id.into(), target_id.into()].span());
        } else {
            set!(world, (minion));
        }
    }

    fn discard(
        world: IWorldDispatcher,
        entity_id: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref special_effects: SpecialEffects
    ) {
        let card = get!(world, (entity_id, battle.id), HandCard);

        discard_utils::discard_effect(world, entity_id, card.card_id, ref battle, ref monster, ref special_effects);

        discard_card(world, ref battle, card.card_id);
        world.delete_entity('hand_card', array![entity_id.into(), battle.id.into()].span());
    }
}