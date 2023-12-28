mod spell_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::battle::battle_utils;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard};
    use thecave::constants::{CardTypes};

    fn spell_effect(
        world: IWorldDispatcher,
        entity_id: u8,
        card_id: u16,
        ref battle: Battle,
        ref monster: Monster,
        ref creature: Creature
    ) {

    }
}