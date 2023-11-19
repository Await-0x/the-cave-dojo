mod attack_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::battle::battle_utils;
    use thecave::models::battle::{Battle, BattleTrait, HandCard, Creature, Monster, DeckCard, SpecialEffects};
    use thecave::constants::{CardTypes};

    fn attack_effect(
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
    }
}