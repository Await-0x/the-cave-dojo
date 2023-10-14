mod DraftUtils {
    use DragonsNest::components::draft::{DraftOption};
    use DragonsNest::utils::cards::CardUtils::{get_card};

    fn get_draft_option(game_id: usize, number: u8, card_id: u16) -> DraftOption {
        let card = get_card(card_id);

        DraftOption {
            game_id,
            number,
            card_id: card.id,
            name: card.name,
            card_type: card.card_type,
            cost: card.cost,
            attack: card.attack,
            health: card.health,
            tag: card.tag,
        }
    }
}