#[system]
mod draft_card {
    use starknet::ContractAddress;
    use traits::{Into, TryInto};
    use dojo::world::Context;

    use DragonsNest::components::game::{Game};
    use DragonsNest::components::draft::{Draft, DraftOption};
    use DragonsNest::components::deck::{DeckCard};
    use DragonsNest::utils::draft::DraftUtils::{get_draft_option};
    use DragonsNest::constants::Messages;

    fn execute(ctx: Context, game_id: usize, number: u8) {
        let mut game = get!(ctx.world, (game_id), Game);
        let mut draft = get!(ctx.world, (game_id), Draft);
        
        assert(game.player == ctx.origin, Messages::NOT_OWNER);
        assert(game.in_draft == true, Messages::NOT_IN_DRAFT);

        let mut choice = get!(ctx.world, (game_id, number), DraftOption);

        let card_count = draft.card_count + 1;

        set!(ctx.world, (
            Draft { game_id, card_count },
        ));

        set!(ctx.world, (
            DeckCard { game_id, card_id: choice.card_id, number: card_count },
        ));

        if card_count < 30 {
            set!(ctx.world, (
                get_draft_option(game_id, 0, 1),
                get_draft_option(game_id, 1, 2),
                get_draft_option(game_id, 2, 3),
            ));
        } else {
            set!(ctx.world, (
                Game { id: game_id, player: ctx.origin, active: true, in_draft: false, in_battle: false, battles_won: 0 },
            ))
        }

        return ();
    }
}
