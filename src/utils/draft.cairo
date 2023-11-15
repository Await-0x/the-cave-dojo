mod DraftUtils {
    use thecave::models::draft::{DraftOption};
    use thecave::utils::cards::CardUtils::{get_card};
    use thecave::utils::random::{get_random_card_id, LCG};

    fn get_draft_options(game_id: usize, entropy: u64) -> (DraftOption, DraftOption, DraftOption) {
        let mut card_1;
        let mut card_2;
        let mut card_3;

        let mut seed = entropy;
        card_1 = get_random_card_id(seed);
        seed = LCG(seed);
        card_2 = get_random_card_id(seed);
        seed = LCG(seed);
        card_3 = get_random_card_id(seed);

        loop {
            if card_1 == card_2 {
                seed = LCG(seed);
                card_2 = get_random_card_id(seed);
                continue;
            }

            if card_1 == card_3 {
                seed = LCG(seed);
                card_3 = get_random_card_id(seed);
                continue;
            }

            if card_2 == card_3 {
                seed = LCG(seed);
                card_3 = get_random_card_id(seed);
                continue;
            }

            break;
        };

        (DraftOption {game_id, 1, card_1}, DraftOption {game_id, 2, card_2}, DraftOption {game_id, 3, card_3})
    }
}