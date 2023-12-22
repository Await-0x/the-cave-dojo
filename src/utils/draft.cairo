mod draft_utils {
    use starknet::{ContractAddress};

    use thecave::models::draft::{DraftOption};
    use thecave::utils::cards::card_utils::{get_card};
    use thecave::utils::random::{get_random_card_id, LCG, get_entropy};

    fn get_draft_options(game_id: usize, card_count: u8) -> (DraftOption, DraftOption, DraftOption) {
        let mut card_1 = 0;
        let mut card_2 = 0;
        let mut card_3 = 0;

        let mut seed = get_entropy(card_count);
        println!("{}", seed);

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

        (
            DraftOption {game_id, option_id: 1, card_id: card_1},
            DraftOption {game_id, option_id: 2, card_id: card_2},
            DraftOption {game_id, option_id: 3, card_id: card_3}
        )
    }
}