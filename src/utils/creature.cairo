mod creature_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::battle::battle_utils;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard};
    use thecave::constants::{CardTypes};

    fn summon_effect(
        world: IWorldDispatcher,
        entity_id: u8,
        card_id: u16,
        ref battle: Battle,
        ref monster: Monster,
    ) {
        if card_id == 1 {
            battle_utils::draw_cards(world, ref battle, 1);
        }
        else if card_id == 2 {
            battle_utils::increase_energy(ref battle, 3);
        }
        else if card_id == 3 {
            monster.taunted_by = entity_id;
        }
        else if card_id == 4 {
            battle_utils::increase_health(ref battle, 3);
        }
        else if card_id == 5 {
            monster.health -= 3;
        }
    }
}