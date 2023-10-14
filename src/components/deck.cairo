#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct DeckCard {
    #[key]
    game_id: usize,
    card_id: u16,
    number: u8
}