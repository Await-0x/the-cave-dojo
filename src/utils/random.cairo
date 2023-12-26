use thecave::constants::{CARD_POOL_SIZE, U128_MAX, DECK_SIZE};
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use thecave::models::battle::{DeckCard, Battle};
use core::{
    array::{SpanTrait, ArrayTrait},
    integer::{
        u8_overflowing_add, u16_overflowing_add, u16_overflowing_sub, U128IntoU256,
        u256_try_as_non_zero, u16_sqrt
    },
    traits::{TryInto, Into},
    clone::Clone, poseidon::poseidon_hash_span, option::OptionTrait, box::BoxTrait,
    starknet::{
        get_caller_address, ContractAddress, ContractAddressIntoFelt252, contract_address_const,
        get_block_timestamp, info::BlockInfo
    },
};

fn split_hash(felt_to_split: felt252) -> u64 {
    // let (d, r) = integer::U256DivRem::div_rem(
    //     felt_to_split.into(), u256_try_as_non_zero(U128_MAX.into()).unwrap()
    // );

    // r.try_into().unwrap()
    get_block_timestamp().into()
}

fn get_entropy(number: u8) -> u64 {
    let mut hash_span = ArrayTrait::<felt252>::new();

    hash_span.append(get_block_timestamp().into());
    hash_span.append(number.into());

    let poseidon: felt252 = poseidon_hash_span(hash_span.span());
    split_hash(poseidon)
}

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

fn shuffle_deck(seed: u8, deck_size: u8) -> Array<u8> {
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

    let mut new_seed: u64 = get_entropy(seed);

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

fn get_random_card_id(entropy: u64) -> u16 {
    (entropy % CARD_POOL_SIZE + 1).try_into().unwrap()
}

fn get_random_deck_card(world: IWorldDispatcher, entropy: u64, battle: Battle) -> DeckCard {
    let rnd: u8 = (entropy % DECK_SIZE.into()).try_into().unwrap();
    let card = get!(world, (battle.id, rnd, battle.deck_number), DeckCard);

    if card.battle_id != 0 {
        return card;
    }

    get_random_deck_card(world, LCG(entropy), battle)
}

#[cfg(test)]
mod tests {
    use debug::PrintTrait;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use core::traits::Into;
    use core::integer::{
        u8_overflowing_add, u16_overflowing_add, u16_overflowing_sub, U128IntoU256,
        u256_try_as_non_zero, u16_sqrt
    };
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

    #[test]
    #[available_gas(10000000)]
    fn test_entropy() {
        let U128_MAX: u128 = 340282366920938463463374607431768211455;
        let felt_to_split: felt252 = '0x0982392390x2lksaedwe';

        let (d, r) = integer::U256DivRem::div_rem(
        felt_to_split.into(), u256_try_as_non_zero(U128_MAX.into()).unwrap()
    );
    }
}