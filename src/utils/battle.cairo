use array::ArrayTrait;

mod battle_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use thecave::utils::cards::card_utils;
    use thecave::models::battle::{Battle, BattleTrait, HandCard, Creature, Monster, DeckCard};
    use thecave::models::card::{Card};
    use thecave::constants::{CardTypes};

    fn gain_health(ref battle: Battle, amount: u8) {
        battle.adventure_health += amount.into();
    }

    fn gain_energy(ref battle: Battle, amount: u8) {
        battle.adventure_energy += amount;
    }

    fn draw_cards(world: IWorldDispatcher, ref battle: Battle, amount: u8) {
        let mut i = 0;

        loop {
            if i == amount {
                break;
            }

            draw_card(world, ref battle);

            i += 1;
        }
    }

    fn add_hand_to_deck(world: IWorldDispatcher, ref battle: Battle) {
        let hand_cards = get_hand_cards(world, ref battle);

        let mut i = 0;

        loop {
            if i == hand_cards.len() {
                break;
            }

            let card_id = *hand_cards.at(i);

            add_card_to_deck(world, ref battle, card_id);

            i += 1;
        };

        battle.hand_total = 0;
    }

    fn add_card_to_deck(world: IWorldDispatcher, ref battle: Battle, card_id: u16) {
        let card = card_utils::get_card(card_id);

        set!(world, (
            DeckCard {
                battle_id: battle.id,
                number: battle.next_number(),
                card_id,
                card_type: card.card_type,
                cost: card.cost,
                attack: card.attack,
                health: card.health
            }
        ));

        battle.deck_size += 1;
    }

    fn draw_card(world: IWorldDispatcher, ref battle: Battle) {
        let next_card: DeckCard = get!(world, (battle.id, battle.deck_index), DeckCard);
        let card: Card = card_utils::get_card(next_card.card_id);

        set!(world, (
            HandCard {
                id: battle.deck_index,
                battle_id: battle.id,
                card_id: card.id,
                card_type: card.card_type,
                cost: card.cost,
                attack: card.attack,
                health: card.health
            }, 
        ));

        battle.deck_index += 1;
        battle.deck_size -= 1;
        battle.hand_total += 1;
    }

    fn get_hand_cards(world: IWorldDispatcher, ref battle: Battle) -> Array<u16> {
        let mut i = 0;
        let mut cards = array![];

        loop {
            if i == battle.hand_total {
                break;
            }

            let hand_card = get!(world, (battle.deck_index - i.into(), battle.id), HandCard);
            if (hand_card.id != 0) {
                cards.append(hand_card.card_id);
            }

            i += 1;
        };

        cards
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
            add_card_to_deck(world, ref battle, creature.card_id);
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
    use thecave::utils::vortex::vortex_utils;
    use thecave::utils::battle::battle_utils::battle_result;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, Minion, SpecialEffects};
    use thecave::constants::{CardTypes};

    fn summon_creature(
        world: IWorldDispatcher,
        entity_id: u16,
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
            add_card_to_deck(world, ref battle, creature.card_id);
            world.delete_entity('Creature', array![creature.id.into(), battle.id.into()].span());
        } else {
            set!(world, (creature));
        }

        if minion.health <= 0 {
            monster.minions_attack -= minion_attack;
            world.delete_entity('Minion', array![battle.id.into(), target_id.into()].span());
        } else {
            set!(world, (minion));
        }
    }

    fn vortex(
        world: IWorldDispatcher,
        entity_id: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref special_effects: SpecialEffects
    ) {
        let card = get!(world, (entity_id, battle.id), HandCard);

        vortex_utils::vortex_effect(world, entity_id, card.card_id, ref battle, ref monster, ref special_effects);

        world.delete_entity('hand_card', array![entity_id.into(), battle.id.into()].span());
    }
}