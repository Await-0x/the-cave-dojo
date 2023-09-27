#[derive(Component, Copy, Drop, Serde)]
struct DraftTracker {
    #[key]
    entity_id: u128,
    count: u32
}

#[derive(Component, Copy, Drop, Serde)]
struct BattleTracker {
    #[key]
    entity_id: u128,
    count: u32
}