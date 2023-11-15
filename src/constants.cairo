const CARD_POOL_SIZE: u16: 100;
const DECK_SIZE: u8 = 20;
const DRAW_AMOUNT: u8 = 5;
const START_HEALTH: u8: 30;

mod CardTypes {
    const CREATURE: felt252 = 'creature';
    const SPELL: felt252 = 'spell';
}

mod ActionTypes {
    const SUMMON_CREATURE: felt252 = 'summon_creature';
    const CAST_SPELL: felt252 = 'cast_spell';
    const ATTACK: felt252 = 'attack';
    const VORTEX: felt252 = 'vortex';
}

mod Messages {
    const NOT_OWNER: felt252 = 'Not authorized to act';
    const NOT_IN_DRAFT: felt252 = 'Not in draft';
    const GAME_OVER: felt252 = 'Game over';
    const IN_BATTLE: felt252 = 'Already in battle';
    const IN_DRAFT: felt252 = 'Draft not over';
}