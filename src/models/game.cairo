use starknet::ContractAddress;
use thecave::models::card::Card;

#[derive(Model, Copy, Drop, Serde)]
struct Game {
    #[key]
    id: usize,
    player: ContractAddress,
    active: bool,
    in_draft: bool,
    in_battle: bool,
    battles_won: u16
}
