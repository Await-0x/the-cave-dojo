#[system]
mod start_draft {
    use dojo::world::Context;

    use DragonsNest::components::draft::{Draft, DraftCard, DraftChoice};
    use DragonsNest::utils::cards::CardUtils::{get_card};

    fn execute(ctx: Context) {
        let draft_id = ctx.world.uuid();

        let card_count = 0;

        set!(ctx.world, (
            Draft { id: draft_id, player: ctx.origin, card_count, active: 1 },
            DraftChoice { draft_id, number: card_count, card: get_card(0) },
            DraftChoice { draft_id, number: card_count + 1, card: get_card(1) },
            DraftChoice { draft_id, number: card_count + 2, card: get_card(2) },
        ));

        return ();
    }
}