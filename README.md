# The Cave

## About the Game

The Cave is a complex fully onchain roguelike deck-building game, coming soon to starknet. Begin your journey by carefully selecting a unique deck of cards comprised of mystical creatures and powerful spells, each with their own unique abilities.

Venture into the perilous depths of the cave, a treacherous place teeming with monstrous adversaries and enigmatic challenges. With every step and every battle, your strategic prowess and the synergies of your team will be put to the test.

## Play the demo

A first look at the cave is available here: https://powerful-vine-409810.ey.r.appspot.com/

The demo includes 100 different cards with unique abilities, a draft phase, and a chance to face off against the first monster "Minotaur".

The demo is free to play, and you don't need to set up any account.

## Game Mechanics

### Draw cards

At the beginning of each round, draw until you have six cards in your hand.
When your deck becomes empty, shuffle your discard pile into your deck.

### Play cards from your hand

Summon creatures and cast spells by paying the energy cost of the card.
You start each round with energy = round, so round_1 = 1 energy, round_2 = 2 energy and so on but (MAX 10 energy).
Unused energy will not transfer over to the next round.

### Discard cards from your hand

You can discard cards from your hand by dragging them to the vortex. Discarding a card cost (1) energy.
This is useful for freeing up space in your hand, so you draw more cards next round.

### Attack the monster

Creatures can attack the monster once each round (except for the round they were summoned).
When attacking the monster, both the creature and the monster takes damage according to each attack power.

### Enemy monsters

At the end of each round, the monster attacks. It will always target your hero unless it has been taunted by a creature.
Each monster has unique abilities happening throughout the fight.

### Limits

Hand: Max 6 cards.
Board: Max 6 creatures.
Health: Max 30 health.
Energy: Max 10 energy.

### Abilities explained

Taunt: Taunt the monster for one round, forcing it to attack the creature.
Shield: The first time this creature is damaged, absorb all damage and remove the shield.
Charge: The creature can attack the same round it was summoned.

## Blockchain

### Transactions

At the end of each round, all your actions taken for that round are bundled into a transaction, and sent to be validated.
In the future, only a proof of your actions will be sent to the chain.

### Reward system

Entry fees are split among the top 3 players on the leaderboard of the current season.

### Clients

To ensure the robustness and availability of the game, the contract will include a client fee to encourage developers to build their own clients
for the game.

## Deployment

Chain - slot