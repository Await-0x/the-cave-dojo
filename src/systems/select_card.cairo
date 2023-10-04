#[system]
mod select_card {
    use starknet::ContractAddress;
    use traits::{Into, TryInto};
    use dojo::world::Context;

    use RealmsLastStand::components::draft::{Draft, DraftCard, DraftChoice};
    use RealmsLastStand::utils::cards::CardUtils::{get_card};
    use RealmsLastStand::constants::messages;

    fn execute(ctx: Context, draft_id: usize, card_number: u8) {
        let mut draft = get!(ctx.world, (draft_id), Draft);
        
        assert(draft.player == ctx.origin, messages::NOT_OWNER);
        assert(card_number >= draft.card_count * 3, messages::INVALID_CARD);

        let mut choice = get!(ctx.world, (draft.id, card_number), DraftChoice);

        let card_count = draft.card_count + 1;

        set!(ctx.world, (
            Draft { id: draft_id, player: ctx.origin, card_count },

            DraftCard { draft_id, number: card_count, card: choice.card },
        ));

        if card_count < 30 {
            set!(ctx.world, (
                DraftChoice { draft_id, number: card_count, card: get_card(0) },
                DraftChoice { draft_id, number: card_count + 1, card: get_card(1) },
                DraftChoice { draft_id, number: card_count + 2, card: get_card(2) }
            ));
        }

        return ();
    }
}
