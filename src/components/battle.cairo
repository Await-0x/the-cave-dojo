#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Battle {
    #[key]
    game_id: usize,
    #[key]
    id: usize,
    active: bool,
}

struct BattleCard {
    #[key]
    battle_id: usize,
    #[key]
    deck_number: u8,
    status: u8,

    card_id: u16,
    name: felt252,
    card_type: felt252,
    cost: u8,
    attack: u8,
    health: u8,
    tag: felt252,
}

