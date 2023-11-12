const NUM_OF_CARDS: u16 = 5;

mod CardTypes {
    const CREATURE: felt252 = 'Creature';
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
}