const ADVENTURER_ID: u16 = 65535;
const CARD_POOL_SIZE: u64 = 100;
const DECK_SIZE: u8 = 20;
const DRAW_AMOUNT: u8 = 6;
const MAX_HEALTH: u16 = 30;
const DISCARD_COST: u8 = 1;
const MAX_BOARD: u8 = 6;

const MAX_ENERGY: u8 = 10;
const START_ENERGY: u8 = 1;

mod CardTypes {
    const CREATURE: felt252 = 'Creature';
    const SPELL: felt252 = 'Spell';
}

mod CardTags {
    const SCAVENGER: felt252 = 'Scavenger';
    const DEMON: felt252 = 'Demon';
    const PRIEST: felt252 = 'Priest';
    const SPELL: felt252 = 'Spell';
}

mod ActionTypes {
    const SUMMON_CREATURE: felt252 = 'summon_creature';
    const CAST_SPELL: felt252 = 'cast_spell';
    const ATTACK: felt252 = 'attack';
    const DISCARD: felt252 = 'discard';
}

mod Messages {
    const NOT_OWNER: felt252 = 'Not authorized to act';
    const NOT_IN_DRAFT: felt252 = 'Not in draft';
    const GAME_OVER: felt252 = 'Game over';
    const IN_BATTLE: felt252 = 'Already in battle';
    const IN_DRAFT: felt252 = 'Draft not over';
}

const U128_MAX: u128 = 340282366920938463463374607431768211455;