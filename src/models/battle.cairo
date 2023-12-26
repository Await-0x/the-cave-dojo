#[derive(Model, Copy, Drop, Serde)]
struct Battle {
    #[key]
    id: usize,
    game_id: usize,
    adventurer_health: u16,
    adventurer_energy: u8,
    round: u16,
    deck_size: u16,
    hand_size: u8,
    deck_number: u8,
    discard_count: u8,
}

#[derive(Model, Copy, Drop, Serde)]
struct Monster {
    #[key]
    battle_id: usize,
    monster_id: u16,
    attack: u16,
    health: u16,
    enrage_turn: u8,
    taunted: bool,
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
    card_tag: felt252,
    attack: u16,
    health: u16,
    shield: bool,
    resting_round: u16,
}

#[derive(Model, Copy, Drop, Serde)]
struct HandCard {
    #[key]
    id: u8,
    #[key]
    battle_id: usize,
    card_id: u16,
    card_type: felt252,
    card_tag: felt252,
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
    card_tag: felt252,
    cost: u8,
    attack: u16,
    health: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct GlobalEffects {
    #[key]
    battle_id: usize,
    scavenger_attack_bonus: u8,
    priest_attack_bonus: u8,
    demon_attack_bonus: u8,
    scavengers_discarded: u8,
}

#[derive(Drop)]
struct Board {   
    creature1: Creature,
    creature2: Creature,
    creature3: Creature,
    creature4: Creature,
    creature5: Creature,
    creature6: Creature,
}

#[derive(Drop)]
struct Hand {   
    hand1: HandCard,
    hand2: HandCard,
    hand3: HandCard,
    hand4: HandCard,
    hand5: HandCard,
    hand6: HandCard,
}

#[derive(Drop)]
struct RoundEffects {   
    adventurer_damaged: bool,
    adventurer_healed: bool,
}
