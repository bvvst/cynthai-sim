const Move = @import("moves.zig").Move;
const std = @import("std");

const VolatileStatusData = struct {
    // there are 60 of these lol

    // major
    abilityChange: ?u16,
    abilitySuppress: ?u8,
    typeChange: ?bool, // not sure where i wanna store this info
    mimic: ?bool,
    substitute: ?u16,
    transformed: ?u8,
    illusion: ?u8,
    perishSongTurn: ?u8,

    // damaging
    bound: ?bool, //
    curse: ?bool,
    nightmare: ?bool,
    flinch: ?bool,
    perishSong: ?bool,
    seeded: ?bool,
    saltCure: ?bool,

    // effectiveness
    automize: ?bool,
    identified: ?bool,
    minimize: ?bool,
    tarshot: ?bool,

    // groundedness
    grounded: ?bool,
    magnetized: ?u8,
    telekinesis: ?u8,

    // healing
    aquaRing: ?bool,
    rooting: ?bool,

    // next turn
    laserFocus: ?bool,
    takingAim: ?bool,
    drowsy: ?bool,

    // priming
    charged: ?bool,
    stockpile: ?u8,
    defenseCurl: ?bool,

    // prevention
    cantEscape: ?bool,
    noRetreat: ?bool,
    octolock: ?bool,
    disable: ?u8,
    embargo: ?u8,
    healBlock: ?u8,
    psychicNoise: ?u8,
    imprison: ?bool,
    taunted: ?u8,
    throatChop: ?u8,
    torment: ?bool,
    confusion: ?bool,
    infatuated: ?bool,

    // stats
    pumped: ?bool,
    guardSplit: ?u8, // hold the index of the monster in the opponent's party
    powerSplit: ?u8,
    speedSwap: ?u8,
    powerTrick: ?u8,

    // forced move
    choiceLock: ?u16, // move
    encore: ?u16, // move
    rampage: ?u16, // move
    rolling: ?u16, // move
    uproar: ?u16, // move

    // multi-turn
    bide: ?u16, // move
    recharging: ?bool,
    charging: ?u16, // move
    semiInvulnerable: ?u8, // move

    // transient
    flinched: ?bool,
    bracing: ?bool,
    // center of attention later
    magicCoat: ?u8, // turn
    protected: ?u8, // turn
};

const Stats = struct { hp: u16, atk: u16, def: u16, spd: u16, spc: u16 };

const Buffs = struct {
    atk: u8, // 1, 2, 3, or 4
    def: u8,
    spd: u8,
    spc: u8,
    evasion: u8,
    accuracy: u8,
    crits: u8,
};

const Type = enum { Fire, Water, Ice, Grass, Electric, Ground, Rock, Flying, Normal, Fighting, Psychic, Ghost, Dragon, Bug, Poison, Dark, Steel, Fairy };

const NonVolatileStatus = enum { Burn, Freeze, Paralysis, Poison, BadlyPoisoned, Sleep, Drowsy };

pub const Monster = struct {
    // constants i think
    speciesIndex: u16,
    typ: Type, // typ because type is a keyword
    abilityIndices: [3]u8,
    moveIndices: [4]u16,
    baseStats: Stats,
    level: u8,

    // battle stuff
    heldItem: u8,
    buffs: Buffs,
    currentHp: u16,
    lastUsedMoveIndex: u16, // for things like mimic, sketch, encore
    nonVolatileStatus: NonVolatileStatus, // only one at a time
    nonVolatileStatusTurn: u8,

    // non volatile status conditions
    volatileStatusData: VolatileStatusData,
};
