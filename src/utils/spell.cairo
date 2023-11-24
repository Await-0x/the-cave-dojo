mod spell_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::battle::battle_utils;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard, SpecialEffects};
    use thecave::constants::{CardTypes};

    fn spell_effect(
        world: IWorldDispatcher,
        entity_id: u16,
        card_id: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref creature: Creature,
        ref special_effects: SpecialEffects
    ) {
        if card_id == 50 {
            battle_utils::draw_cards(world, ref battle, 1);
        }
        else if card_id == 51 {
            battle_utils::increase_energy(ref battle, 3);
        }
        else if card_id == 52 {
            monster.taunted_by = creature.id;
        }
        else if card_id == 53 {
            battle_utils::increase_health(ref battle, 3);
        }
        else if card_id == 54 {
            monster.health -= 3;
        }
    }
}