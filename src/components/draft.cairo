use RealmsLastStand::components::card::Card;

#[derive(Component, Copy, Drop, Serde)]
struct Draft {
    #[key]
    id: u32,
    player: ContractAddress,
    card_count: u8
}

#[derive(Component, Copy, Drop, Serde)]
struct DraftCard {
    #[key]
    draft_id: u32,
    #[key]
    number: u8,
    card: Card,
}

#[derive(Component, Copy, Drop, Serde)]
struct DraftChoice {
    #[key]
    draft_id: u32,
    #[key]
    number: u8,
    card: Card,
}