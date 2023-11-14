use debug::PrintTrait;

fn LCG(seed: u64) -> u64 {
    let a = 1664525;
    let c = 1013904223;
    let m = 4294967296;

    (a * seed + c) % m
}

fn remove_card(deck: Span<u8>, index: u8) -> Array<u8> {
    let mut new_deck: Array<u8> = ArrayTrait::new();
    let mut i: u32 = 0;

    loop {
        if i >= deck.len() {
            break;
        }

        if *deck.at(i) == index {
            i += 1;
            continue;
        }

        new_deck.append(*deck.at(i));

        i += 1;
    };

    new_deck
}

fn shuffle_deck(seed: u64, deck_size: u8) -> Array<u8> {
    let mut original_deck: Array<u8> = ArrayTrait::new();
    let mut shuffled_deck: Array<u8> = ArrayTrait::new();

    let mut i: u8 = 0;
    loop {
        if i >= deck_size {
            break;
        }

        original_deck.append(i);
        
        i += 1;
    };

    let mut new_seed: u64 = seed;

    loop {
        if shuffled_deck.len() == deck_size.into() {
            break;
        }

        let mut new_seed = LCG(new_seed);
        let random_index = new_seed % original_deck.len().into();
        let card = *original_deck.at(random_index.try_into().unwrap());

        original_deck = remove_card(original_deck.span(), card);

        shuffled_deck.append(card);
    };
    
    shuffled_deck
}

#[cfg(test)]
mod tests {
    use debug::PrintTrait;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use core::traits::Into;
    use dojo::world::IWorldDispatcherTrait;
    use core::array::SpanTrait;
    use thecave::utils::random::shuffle_deck;

    #[test]
    #[available_gas(10000000)]
    fn test_shuffle_deck() {
        let seed = 2;
        let deck_size = 20;

        let mut deck = shuffle_deck(seed, deck_size);
        assert(deck.len() == 20, 'deck should be decksize');
        assert(*deck.at(0) != *deck.at(1), 'should be different cards');
    }
}