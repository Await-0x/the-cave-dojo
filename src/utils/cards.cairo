mod card_utils {
    use array::ArrayTrait;
    use thecave::models::card::{Card};
    use thecave::constants::{CardTypes, CardTags};

    fn get_card(id: u16) -> Card {
        if id == 1 {
            return Card {
                id: 1,
                name: 'Fireball',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SPELL,
                cost: 5,
                attack: 0,
                health: 0,
            };
        }

        else if id == 2 {
            return Card {
                id: 2,
                name: 'Vulture',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 2,
                attack: 1,
                health: 1,
            };
        }
        
        else if id == 3 {
            return Card {
                id: 3,
                name: 'Hyena',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 3,
                attack: 2,
                health: 1,
            };
        }
        
        else if id == 4 {
            return Card {
                id: 4,
                name: 'Wild Dog',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 3,
                attack: 1,
                health: 3,
            };
        }
        
        else if id == 5 {
            return Card {
                id: 5,
                name: 'Jackal',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 12,
                attack: 8,
                health: 8,
            };
        }
        
        else if id == 6 {
            return Card {
                id: 6,
                name: 'Crow',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 1,
                attack: 1,
                health: 2,
            };
        }
        
        else if id == 7 {
            return Card {
                id: 7,
                name: 'Buzzard',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 6,
                attack: 4,
                health: 3,
            };
        }
        
        else if id == 8 {
            return Card {
                id: 8,
                name: 'Raven',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 5,
                attack: 4,
                health: 3,
            };
        }
        
        else if id == 9 {
            return Card {
                id: 9,
                name: 'Wolverine',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 4,
                attack: 3,
                health: 2,
            };
        }
        
        else if id == 10 {
            return Card {
                id: 10,
                name: 'Coyote',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 2,
                attack: 2,
                health: 2,
            };
        }
        
        else if id == 11 {
            return Card {
                id: 11,
                name: 'Kite',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 4,
                attack: 2,
                health: 6,
            };
        }
        
        else if id == 12 {
            return Card {
                id: 12,
                name: 'Rat',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 1,
                attack: 2,
                health: 1,
            };
        }
        
        else if id == 13 {
            return Card {
                id: 13,
                name: 'Crab',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 5,
                attack: 5,
                health: 2,
            };
        }
        
        else if id == 14 {
            return Card {
                id: 14,
                name: 'Magpie',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 1,
                attack: 1,
                health: 2,
            };
        }
        
        else if id == 15 {
            return Card   {
                id: 15,
                name: 'Seagull',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 2,
                attack: 2,
                health: 3,
            };
        }
        
        else if id == 16 {
            return Card {
                id: 16,
                name: 'Condor',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 3,
                attack: 3,
                health: 4,
            };
        }
        
        else if id == 17 {
            return Card {
                id: 17,
                name: 'Fox',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 4,
                attack: 4,
                health: 5,
            };
        }
        
        else if id == 18 {
            return Card {
                id: 18,
                name: 'Opossum',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 5,
                attack: 5,
                health: 6,
            };
        }
        
        else if id == 19 {
            return Card {
                id: 19,
                name: 'Marabou',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 6,
                attack: 6,
                health: 7,
            };
        }
        
        else if id == 20 {
            return Card {
                id: 20,
                name: 'Frigatebird',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 1,
                attack: 1,
                health: 1,
            };
        }
        
        else if id == 21 {
            return Card {
                id: 21,
                name: 'Tasmanian Devil',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 3,
                attack: 2,
                health: 4,
            };
        }
        
        else if id == 22 {
            return Card {
                id: 22,
                name: 'Bald Eagle',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 7,
                attack: 7,
                health: 7,
            };
        }
        
        else if id == 23 {
            return Card {
                id: 23,
                name: 'King Vulture',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 3,
                attack: 3,
                health: 2,
            };
        }
        
        else if id == 24 {
            return Card {
                id: 24,
                name: 'Griffon',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 5,
                attack: 5,
                health: 2,
            };
        }
        
        else if id == 25 {
            return Card {
                id: 25,
                name: 'Binturong',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 7,
                attack: 7,
                health: 2,
            };
        }
        
        else if id == 26 {
            return Card {
                id: 26,
                name: 'Hedgehog',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 2,
                attack: 2,
                health: 3,
            };
        }
        
        else if id == 27 {
            return Card {
                id: 27,
                name: 'Chipmunk',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 3,
                attack: 3,
                health: 4,
            };
        }
        
        else if id == 28 {
            return Card {
                id: 28,
                name: 'Sarcophagus',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 4,
                attack: 4,
                health: 5,
            };
        }
        
        else if id == 29 {
            return Card {
                id: 29,
                name: 'Skunk',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 5,
                attack: 5,
                health: 6,
            };
        }
        
        else if id == 30 {
            return Card {
                id: 30,
                name: 'Caterpillar',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 6,
                attack: 6,
                health: 7,
            };
        }
        
        else if id == 31 {
            return Card {
                id: 31,
                name: 'Grub Worm',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 3,
                attack: 1,
                health: 1,
            };
        }
        
        else if id == 32 {
            return Card {
                id: 32,
                name: 'Raccoon',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 4,
                attack: 3,
                health: 3,
            };
        }
        
        else if id == 33 {
            return Card {
                id: 33,
                name: 'Beetle',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 2,
                attack: 1,
                health: 1,
            };
        }

        else if id == 34 {
            return Card {
                id: 34,
                name: 'Weasel',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::SCAVENGER,
                cost: 8,
                attack: 8,
                health: 8,
            };
        }

        else if id == 35 {
            return Card {
                id: 35,
                name: 'Abyss Walker',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 2,
                attack: 1,
                health: 1,
            };
        }

        else if id == 36 {
            return Card {
                id: 36,
                name: 'Blight Herald',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 3,
                attack: 2,
                health: 1,
            };
        }

        else if id == 37 {
            return Card {
                id: 37,
                name: 'Chaos Bringer',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 3,
                attack: 1,
                health: 3,
            };
        }

        else if id == 38 {
            return Card {
                id: 38,
                name: 'Dread Wraith',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 12,
                attack: 8,
                health: 8,
            };
        }

        else if id == 39 {
            return Card {
                id: 39,
                name: 'Ghoul Ravager',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 1,
                attack: 1,
                health: 2,
            };
        }

        else if id == 40 {
            return Card {
                id: 40,
                name: 'Havoc Whisperer',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 6,
                attack: 4,
                health: 3,
            };
        }

        else if id == 41 {
            return Card {
                id: 41,
                name: 'Bane Summoner',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 5,
                attack: 4,
                health: 3,
            };
        }

        else if id == 42 {
            return Card {
                id: 42,
                name: 'Fiery Demon',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 4,
                attack: 3,
                health: 2,
            };
        }

        else if id == 43 {
            return Card {
                id: 43,
                name: 'Zarthos',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 2,
                attack: 2,
                health: 2,
            };
        }

        else if id == 44 {
            return Card {
                id: 44,
                name: 'Inferno Lord',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 1,
                attack: 3,
                health: 2,
            };
        }

        else if id == 45 {
            return Card {
                id: 45,
                name: 'Jinx Weaver',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 6,
                attack: 6,
                health: 4,
            };
        }

        else if id == 46 {
            return Card {
                id: 46,
                name: 'Reaver',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 4,
                attack: 2,
                health: 6,
            };
        }

        else if id == 47 {
            return Card {
                id: 47,
                name: 'Nether Fiend',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 1,
                attack: 2,
                health: 1,
            };
        }

        else if id == 48 {
            return Card {
                id: 48,
                name: 'Pestilence Monger',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 5,
                attack: 5,
                health: 2,
            };
        }

        else if id == 49 {
            return Card {
                id: 49,
                name: 'Ravage Beast',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 4,
                attack: 4,
                health: 5,
            };
        }

        else if id == 50 {
            return Card {
                id: 50,
                name: 'Zephyr',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 5,
                attack: 5,
                health: 6,
            };
        }

        else if id == 51 {
            return Card {
                id: 51,
                name: 'Grim Marauder',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 6,
                attack: 6,
                health: 7,
            };
        }

        else if id == 52 {
            return Card {
                id: 52,
                name: 'Doom Bringer',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 1,
                attack: 1,
                health: 1,
            };
        }

        else if id == 53 {
            return Card {
                id: 53,
                name: 'Scream Shrieker',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 3,
                attack: 2,
                health: 4,
            };
        }

        else if id == 54 {
            return Card {
                id: 54,
                name: 'Vex',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 7,
                attack: 7,
                health: 7,
            };
        }

        else if id == 55 {
            return Card {
                id: 55,
                name: 'Phantom',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 3,
                attack: 3,
                health: 2,
            };
        }

        else if id == 56 {
            return Card {
                id: 56,
                name: 'Seraphex',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 5,
                attack: 5,
                health: 2,
            };
        }

        else if id == 57 {
            return Card {
                id: 57,
                name: 'Devourer',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 7,
                attack: 7,
                health: 2,
            };
        }

        else if id == 58 {
            return Card {
                id: 58,
                name: 'Haunter',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 2,
                attack: 2,
                health: 3,
            };
        }

        else if id == 59 {
            return Card {
                id: 59,
                name: 'Eerie Sentinel',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 3,
                attack: 3,
                health: 4,
            };
        }

        else if id == 60 {
            return Card {
                id: 60,
                name: 'Nightmare Weaver',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 4,
                attack: 4,
                health: 5,
            };
        }

        else if id == 61 {
            return Card {
                id: 61,
                name: 'Cinder Ghast',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 5,
                attack: 5,
                health: 6,
            };
        }

        else if id == 62 {
            return Card {
                id: 62,
                name: 'Gloom Stalker',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 6,
                attack: 6,
                health: 7,
            };
        }

        else if id == 63 {
            return Card {
                id: 63,
                name: 'Rage Infernal',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 4,
                attack: 6,
                health: 7,
            };
        }

        else if id == 64 {
            return Card {
                id: 64,
                name: 'Void Reckoner',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 4,
                attack: 3,
                health: 3,
            };
        }

        else if id == 65 {
            return Card {
                id: 65,
                name: 'Sorrow Monger',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 2,
                attack: 1,
                health: 1,
            };
        }

        else if id == 66 {
            return Card {
                id: 66,
                name: 'Flame Warden',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::DEMON,
                cost: 8,
                attack: 8,
                health: 8,
            };
        }

        else if id == 67 {
            return Card {
                id: 67,
                name: 'Lava Wave',
                card_type: CardTypes::SPELL,
                card_tag: CardTags::SPELL,
                cost: 5,
                attack: 0,
                health: 0,
            };
        }

        else if id == 68 {
            return Card {
                id: 68,
                name: 'Light Herald',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 5,
                attack: 5,
                health: 6,
            };
        }

        else if id == 69 {
            return Card {
                id: 69,
                name: 'Harmony Seer',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 3,
                attack: 2,
                health: 1,
            };
        }

        else if id == 70 {
            return Card   {
                id: 70,
                name: 'Wisdom Bringer',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 3,
                attack: 1,
                health: 3,
            };
        }

        else if id == 71 {
            return Card {
                id: 71,
                name: 'Grace Warden',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 3,
                attack: 2,
                health: 2,
            };
        }

        else if id == 72 {
            return Card {
                id: 72,
                name: 'Faith Guardian',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 1,
                attack: 1,
                health: 2,
            };
        }

        else if id == 73 {
            return Card {
                id: 73,
                name: 'Hope Weaver',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 6,
                attack: 4,
                health: 3,
            };
        }

        else if id == 74 {
            return Card {
                id: 74,
                name: 'Soul Shepherd',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 5,
                attack: 4,
                health: 3,
            };
        }

        else if id == 75 {
            return Card {
                id: 75,
                name: 'Blessing Caster',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 4,
                attack: 3,
                health: 2,
            };
        }

        else if id == 76 {
            return Card {
                id: 76,
                name: 'Spirit Sage',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 2,
                attack: 2,
                health: 2,
            };
        }

        else if id == 77 {
            return Card {
                id: 77,
                name: 'Divine Speaker',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 1,
                attack: 2,
                health: 1,
            };
        }

        else if id == 78 {
            return Card {
                id: 78,
                name: 'Chant Monk',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 6,
                attack: 6,
                health: 4,
            };
        }

        else if id == 79 {
            return Card {
                id: 79,
                name: 'Mystic Vicar',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 4,
                attack: 2,
                health: 6,
            };
        }

        else if id == 80 {
            return Card {
                id: 80,
                name: 'Prayer Chanter',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 1,
                attack: 2,
                health: 1,
            };
        }

        else if id == 81 {
            return Card {
                id: 81,
                name: 'Ritual Preacher',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 5,
                attack: 5,
                health: 2,
            };
        }

        else if id == 82 {
            return Card {
                id: 82,
                name: 'Oracle Priest',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 2,
                attack: 2,
                health: 1,
            };
        }

        else if id == 83 {
            return Card {
                id: 83,
                name: 'Sanctity Envoy',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 4,
                attack: 4,
                health: 5,
            };
        }

        else if id == 84 {
            return Card {
                id: 84,
                name: 'Purity Vicar',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 5,
                attack: 5,
                health: 6,
            };
        }

        else if id == 85 {
            return Card {
                id: 85,
                name: 'Hallow Emissary',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 6,
                attack: 6,
                health: 7,
            };
        }

        else if id == 86 {
            return Card {
                id: 86,
                name: 'Peace Keeper',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 1,
                attack: 1,
                health: 1,
            };
        }

        else if id == 87 {
            return Card {
                id: 87,
                name: 'Truth Seeker',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 3,
                attack: 2,
                health: 4,
            };
        }

        else if id == 88 {
            return Card {
                id: 88,
                name: 'Mercy Giver',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 7,
                attack: 7,
                health: 7,
            };
        }

        else if id == 89 {
            return Card {
                id: 89,
                name: 'Serenade Cleric',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 3,
                attack: 3,
                health: 2,
            };
        }

        else if id == 90 {
            return Card {
                id: 90,
                name: 'Ethereal Clergy',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 5,
                attack: 5,
                health: 2,
            };
        }

        else if id == 91 {
            return Card {
                id: 91,
                name: 'Celestial Minister',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 7,
                attack: 7,
                health: 2,
            };
        }

        else if id == 92 {
            return Card {
                id: 92,
                name: 'Heavenly Parson',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 2,
                attack: 2,
                health: 3,
            };
        }

        else if id == 93 {
            return Card {
                id: 93,
                name: 'Virtue Curate',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 3,
                attack: 3,
                health: 4,
            };
        }

        else if id == 94 {
            return Card {
                id: 94,
                name: 'Eden Priest',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 4,
                attack: 4,
                health: 5,
            };
        }

        else if id == 95 {
            return Card {
                id: 95,
                name: 'Aurora Priestess',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 5,
                attack: 5,
                health: 6,
            };
        }

        else if id == 96 {
            return Card {
                id: 96,
                name: 'Divinity Channeler',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 6,
                attack: 6,
                health: 7,
            };
        }

        else if id == 97 {
            return Card {
                id: 97,
                name: 'Gospel Scribe',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 3,
                attack: 1,
                health: 1,
            };
        }

        else if id == 98 {
            return Card {
                id: 98,
                name: 'Solace Bringer',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 4,
                attack: 3,
                health: 3,
            };
        }

        else if id == 99 {
            return Card {
                id: 99,
                name: 'Reverence Monk',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 2,
                attack: 1,
                health: 1,
            };
        }

        else if id == 100 {
            return Card {
                id: 100,
                name: 'Sanctum Prophet',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 8,
                attack: 8,
                health: 8,
            };
        }

        else {
            return Card {
                id: 0,
                name: 'Unknown',
                card_type: CardTypes::CREATURE,
                card_tag: CardTags::PRIEST,
                cost: 0,
                attack: 0,
                health: 0,
            };
        }
    }
}