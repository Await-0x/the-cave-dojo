mod discard_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::utils::battle::battle_utils;
    use thecave::models::battle::{Battle, HandCard, Creature, Monster, DeckCard};
    use thecave::constants::{CardTypes};

    fn discard_effect(
        world: IWorldDispatcher,
        entity_id: u16,
        card_id: u16,
        ref battle: Battle,
        ref monster: Monster,
    ) {
        if card_id == 50 {
            battle_utils::draw_cards(world, ref battle, 1);
        }
    }
}