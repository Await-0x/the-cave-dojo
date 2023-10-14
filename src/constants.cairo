const NUM_OF_CARDS: u16 = 5;

mod CardTypes {
    const CREATURE: felt252 = 'Creature';
    const SPELL: felt252 = 'spell';
}

mod CardTags {
    const BEAST: felt252 = 'Beast';
    const UNDEAD: felt252 = 'Undead';
    const HUMAN: felt252 = 'Human';
}

mod BattleCardStatus {
    const DECK: felt252 = 'Deck';
}

mod Messages {
    const NOT_OWNER: felt252 = 'Not authorized to act';
    const NOT_IN_DRAFT: felt252 = 'Not in draft';
}

