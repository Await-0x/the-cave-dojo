use starknet::ContractAddress;
use RealmsLastStand::components::card::Card;

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Draft {
    #[key]
    id: usize,
    #[key]
    player: ContractAddress,
    card_count: u8
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct DraftCard {
    #[key]
    draft_id: usize,
    #[key]
    number: u8,
    card: Card,
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct DraftChoice {
    #[key]
    draft_id: usize,
    #[key]
    number: u8,
    card: Card,
}