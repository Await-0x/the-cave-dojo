const GAME_CONFIG: felt252 = 9999999999999;
const NUM_CARDS: u16 = 5;

mod card_id {    
    const Bear: u16 = 0;
    const Wolf: u16 = 1;
    const Ghoul: u16 = 2;
    const Ranger: u16 = 3;
    const Dragon: u16 = 4;
}

mod messages {
    const NOT_OWNER: felt252 = 'Not authorized to act';
}
