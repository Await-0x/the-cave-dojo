use starknet::ContractAddress;
use DragonsNest::components::card::Card;

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Game {
    #[key]
    id: usize,
    player: ContractAddress,
    active: bool,
    in_draft: bool,
    in_battle: bool,
    battles_won: u16
}
