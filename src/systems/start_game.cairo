#[system]
mod start_game {
    use dojo::world::Context;

    use DragonsNest::components::game::Game;
    use DragonsNest::components::draft::{Draft, DraftOption};
    use DragonsNest::utils::draft::DraftUtils::{get_draft_option};

    fn execute(ctx: Context) {
        let game_id = ctx.world.uuid();

        let card_count = 0;

        set!(ctx.world, (
            Game { id: game_id, player: ctx.origin, active: true, in_draft: true, in_battle: false, battles_won: 0 },
            Draft { game_id, card_count: 0 }
        ));

        set!(ctx.world, (
            get_draft_option(game_id, 0, 1),
            get_draft_option(game_id, 1, 2),
            get_draft_option(game_id, 2, 3),
        ));

        return ();
    }
}