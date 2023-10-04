#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Card {
    #[key]
    id: u16,
    name: felt252,
    cost: u8,
    attack: u8,
    health: u8
}