#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Card {
    #[key]
    id: u32,
    cost: u8,
    attack: u8,
    health: u8
}