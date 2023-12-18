#[derive(Model, Copy, Drop, Serde)]
struct Card {
    #[key]
    id: u16,
    name: felt252,
    card_type: felt252,
    card_tag: felt252,
    cost: u8,
    attack: u16,
    health: u16,
}