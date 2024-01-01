mod round_utils {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use array::ArrayTrait;
    use thecave::utils::{
        battle::battle_utils,
        board::board_utils
    };
    use thecave::models::battle::{Battle, Monster, Board, Hand, RoundEffects};

    fn end_of_round_effect(
        world: IWorldDispatcher,
        ref battle: Battle,
        ref monster: Monster,
        ref hand: Hand,
        ref board: Board,
        ref round_effects: RoundEffects,
    ) {
        battle_utils::heal_adventurer(world, ref battle, board_utils::count_card_id(ref board, 71).into() * 3, ref monster, ref hand, ref board, ref round_effects);
    }
}