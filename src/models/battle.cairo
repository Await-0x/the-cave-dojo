#[derive(Model, Copy, Drop, Serde)]
struct Battle {
    #[key]
    id: usize,
    game_id: usize,
    active: bool,
    adventure_health: u16,
    round: u16,
    board_count: u8,
    hand_count: u8,
    vortex_count: u8,
    deck_index: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct Monster {
    #[key]
    battle_id: usize,
    monster_id: u8,
    attack: u16,
    health: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct Creature {
    #[key]
    id: usize,
    card_id: u16,
    battle_id: usize,
    attack: u16,
    health: u16,
    resting: bool
}

#[derive(Model, Copy, Drop, Serde)]
struct HandCard {
    #[key]
    id: u16,
    battle_id: usize,
    card_id: u16,
    card_type: u8,
    cost: u8,
    attack: u16,
    health: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct DeckCard {
    #[key]
    battle_id: usize,
    #[key]
    number: u16,
    card_id: u16,
    card_type: u8,
    cost: u8,
    attack: u16,
    health: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct VortexCard {
    #[key]
    id: u16,
    battle_id: usize,
    card_id: u16,
}


