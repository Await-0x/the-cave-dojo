#[system]
mod select_card {
    use starknet::ContractAddress;
    use traits::{Into, TryInto};
    use dojo::world::Context;

    use RealmsLastStand::components::draft::{Draft, DraftCard, DraftChoice};
    use RealmsLastStand::constants::messages;
    use RealmsLastStand::traits:draft::DraftImpl

    fn execute(ctx: Context, draft_id: u32, card_number: u8) {
        let mut draft = get!(ctx.world, (draft_id), Draft);
        
        assert(draft.player == ctx.origin, messages::NOT_OWNER);
        assert(card_number >= draft.card_count * 3);

        let mut choice = get!(ctx.world, (draft.id, card_number), DraftChoice);

        let card_count = draft.count_count + 1

        set!(ctx.world, (DraftCard { id: draft.id, number: card_count, card: choice.card }));
        
        set!(ctx.world, (Draft { id: draft_id, player: ctx.origin, card_count }));

        set!(ctx.world, (DraftChoice { id: draft_id, number: card_count * 3, card: DraftImpl::get_card(1) }));
        set!(ctx.world, (DraftChoice { id: draft_id, number: card_count * 3 + 1, card: DraftImpl::get_card(1) }));
        set!(ctx.world, (DraftChoice { id: draft_id, number: card_count * 3 + 2, card: DraftImpl::get_card(2) }));
    }
}
