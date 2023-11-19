#[derive(Model, Copy, Drop, Serde)]
struct Battle {
    #[key]
    id: usize,
    game_id: usize,
    adventure_health: u16,
    adventure_energy: u8,
    round: u16,
    deck_index: u16,
    deck_size: u16,
    hand_total: u8, // Total amount of cards we had during the turn. Used to fetch hand.
    board_count: u8,
    vortex_count: u8,
}

#[derive(Model, Copy, Drop, Serde)]
struct Monster {
    #[key]
    battle_id: usize,
    monster_id: u8,
    attack: u16,
    health: u16,
    taunted_by: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct Creature {
    #[key]
    id: u16,
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
    id: u16,
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
    number: u16,
    card_id: u16,
    card_type: felt252,
    cost: u8,
    attack: u16,
    health: u16
}

#[derive(Model, Copy, Drop, Serde)]
struct VortexCard {
    #[key]
    id: u16,
    #[key]
    battle_id: usize,
    card_id: u16,
}

#[derive(Model, Copy, Drop, Serde)]
struct SpecialEffects {
    #[key]
    battle_id: usize,
    sleep: bool,
    vortex_limit: u8,
    draw_from_vortex: bool,
    vortex_draw: bool,
    vortex_energy: bool,
    vortex_hand: bool,
    draw_extra_life_cost: bool
}

trait BattleTrait {
    fn next_number(self: Battle) -> u16;
}

impl BattleImpl of BattleTrait {
    fn next_number(self: Battle) -> u16 {
        self.deck_index + self.deck_size
    }
}