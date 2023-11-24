#[derive(Model, Copy, Drop, Serde)]
struct Battle {
    #[key]
    id: usize,
    game_id: usize,
    adventure_health: u16,
    adventure_energy: u8,
    round: u16,
    deck_size: u16,
    hand_size: u8,
    board_count: u8,
    deck_number: u8,
    discard_count: u8,
}

#[derive(Model, Copy, Drop, Serde)]
struct Monster {
    #[key]
    battle_id: usize,
    monster_id: u8,
    attack: u16,
    health: u16,
    enrage_turn: u8,
    taunted_by: u8,
    minions_attack: u16,
}

#[derive(Model, Copy, Drop, Serde)]
struct Minion {
    #[key]
    battle_id: usize,
    #[key]
    number: u8,
    attack: u16,
    health: u16,
}

#[derive(Model, Copy, Drop, Serde)]
struct Creature {
    #[key]
    id: u8,
    #[key]
    battle_id: usize,
    card_id: u16,
    attack: u16,
    health: u16,
    resting: bool
}

#[derive(Model, Copy, Drop, Serde)]
struct HandCard {
    #[key]
    id: u8,
    #[key]
    battle_id: usize,
    card_id: u16,
    card_type: felt252,
    cost: u8,
    attack: u16,
    health: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct DeckCard {
    #[key]
    battle_id: usize,
    #[key]
    deck_number: u8,
    #[key]
    card_number: u8,
    card_id: u16,
    card_type: felt252,
    cost: u8,
    attack: u16,
    health: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct SpecialEffects {
    #[key]
    battle_id: usize,
    sleep: bool,
    discard_cost: u8,
    draw_extra_life_cost: bool
}