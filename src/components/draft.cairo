use starknet::ContractAddress;

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Draft {
    #[key]
    game_id: usize,
    card_count: u8,
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct DraftOption {
    #[key]
    game_id: usize,
    #[key]
    number: u8,
    // Card info
    card_id: u16,
    name: felt252,
    card_type: felt252,
    cost: u8,
    attack: u8,
    health: u8,
    tag: felt252,
}