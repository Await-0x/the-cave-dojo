fn LCG(seed: u64) {
    let a = 1664525;
    let c = 1013904223;
    let m = 2^32;

    (a * seed + c) % m;
}

fn remove_card(deck: Array<u8>, index: u8) -> Array<u8> {
    let mut new_deck: Array<u8> = ArrayTrait::new();
    let mut i: u16 = 0;

    loop {
        if i >= deck.len() {
            break;
        }

        if *deck.at(i) == index {
            continue;
        }

        new_deck.append(*deck.at(i));

        i += 1;
    };

    new_deck;
  }

fn shuffle_deck_recursive(seed: u64, original_deck: Array<u8>, shuffled_deck: Array<u8>) {
    if original_deck.len() == 0 {
        return shuffled_deck;
    }

    else {
        let mut seed = LCG(seed);
        let random_index = seed % original_deck.len();
        let card = *original_deck.at(random_index);

        let updated_original_deck = remove_card(original_deck, card);

        shuffled_deck.append(card);

        return shuffle_deck_recursive(seed, updated_original_deck, shuffled_deck)
    }
}

fn shuffle_deck(seed: u64, deck_size: u8) -> Array<u8> {
    let mut original_deck = ArrayTrait::new();
    let mut i: u16 = 0;

    loop {
        if i >= deck_size {
            break;
        }

        original_deck.append(i);
        
        i += 1;
    }

    let mut shuffled_deck = ArrayTrait::new();
    
    shuffle_deck_recursive(seed, original_deck, shuffled_deck);
}