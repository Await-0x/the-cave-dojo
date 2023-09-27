#[system]
mod start_draft {
    use traits::{TryInto};
    use dojo::world::Context;

    use RealmsLastStand::components::draft::{Draft, DraftCard, DraftChoice};
    use RealmsLastStand::components::DraftTracker;
    use RealmsLastStand::constants::GAME_CONFIG;
    use RealmsLastStand::traits:draft::DraftImpl

    fn execute(ctx: Context) -> u32 {
        let mut draft_tracker = get!(ctx.world, (GAME_CONFIG), DraftTracker);
        let draft_id = draft_tracker.count + 1;

        set!(ctx.world, (Draft { id: draft_id, player: ctx.origin, card_count: 0 }));

        set!(ctx.world, (DraftTracker { entity_id: GAME_CONFIG.try_into().unwrap(), count: draft_id }));

        set!(ctx.world, (DraftChoice { id: draft_id, number: 0, card: DraftImpl::get_card(0) }));
        set!(ctx.world, (DraftChoice { id: draft_id, number: 1, card: DraftImpl::get_card(1) }));
        set!(ctx.world, (DraftChoice { id: draft_id, number: 2, card: DraftImpl::get_card(2) }));

        // Emit World Event
        return (draft_id);
    }
}