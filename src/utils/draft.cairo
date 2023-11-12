mod DraftUtils {
    use thecave::models::draft::{DraftOption};
    use thecave::utils::cards::CardUtils::{get_card};

    fn get_draft_option(game_id: usize, option_id: u8, card_id: u16) -> DraftOption {
        let card = get_card(card_id);

        DraftOption {
            game_id,
            option_id,
            card_id,
        }
    }
}