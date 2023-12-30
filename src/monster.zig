const Move = @import("moves.zig").Move;
const std = @import("std");

const VolatileStatusFlags = struct {
    // there are 60 of these lol

    // major
    abilityChange: bool = false,
    abilitySuppress: bool = false,
    typeChange: bool = false,
    mimic: bool = false,
    substitute: bool = false,
    transformed: bool = false,
    illusion: bool = false,

    // damaging
    bound: bool = false,
    curse: bool = false,
    nightmare: bool = false,
    flinch: bool = false,
    perishSong: bool = false,
    seeded: bool = false,
    saltCure: bool = false,

    // effectiveness
    automize: bool = false,
    identified: bool = false,
    minimize: bool = false,
    tarshot: bool = false,

    // groundedness
    grounded: bool = false,
    magnetized: bool = false,
    telekinesis: bool = false,

    // healing
    aquaRing: bool = false,
    rooting: bool = false,

    // next turn
    laserFocus: bool = false,
    takingAim: bool = false,
    drowsy: bool = false,

    // priming
    charged: bool = false,
    stockpile: bool = false,
    defenseCurl: bool = false,

    // prevention
    cantEscape: bool = false,
    noRetreat: bool = false,
    octolock: bool = false,
    disable: bool = false,
    embargo: bool = false,
    healBlock: bool = false,
    psychicNoise: bool = false,
    imprison: bool = false,
    taunted: bool = false,
    throatChop: bool = false,
    torment: bool = false,
    confusion: bool = false,
    infatuated: bool = false,

    // stats
    pumped: bool = false,
    guardSplit: bool = false,
    powerSplit: bool = false,
    speedSwap: bool = false,
    powerTrick: bool = false,

    // forced move
    choiceLock: bool = false,
    encore: bool = false,
    rampage: bool = false,
    rolling: bool = false,
    uproar: bool = false,

    // multi-turn
    bide: bool = false,
    recharging: bool = false,
    charging: bool = false,
    semiInvulnerable: bool = false,

    // transient
    flinched: bool = false,
    bracing: bool = false,

    // center of attention later
    magicCoat: bool = false,
    protected: bool = false,
};

const VolatileStatusConditionData = union(enum) {
    // major
    abilityIndex: u16, // ability index
    typeChange: [2]u16,
    // mimic: u16, // logic handled elsewhere
    substituteHealth: u16,
    transformTarget: *Monster,
    illusionTarget: *Monster,
    perishSongTurn: u16,

    // groundedness
    magnetizedTurn: u16,
    telekinesisTurn: u16,

    // priming
    stockpileCount: u16,

    // prevention
    disableTurn: u16,
    embargoTurn: u16,
    healBlockTurn: u16,
    psychicNoiseTurn: u16,
    tauntedTurn: u16,
    throatChopTurn: u16,
    // torment: u16, // could store last move index but lastUsedMoveIndex is already a thing

    // stats
    guardSplitTarget: *Monster,
    powerSplitTarget: *Monster,
    speedSwapTarget: *Monster,
    powerTrickTarget: *Monster,

    // forced move
    choiceLockMoveIndex: u16,
    encoreMoveIndex: u16,
    rampageMove: u16,
    rollingMove: u16,
    uproarMove: u16,

    // multi-turn
    bideMove: u16,
    chargingMove: u16, // includes bounce, dig, dive, fly etc
    semiInvulnerableTypeIndex: u16, // 1=Fly 2=Dig 3=Dive 4=Bounce 5=Shadow Force 6=Phantom Force

    // transient
    magicCoat: u16,
    protectionTurn: u16,
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
    speciesIndex: u16,
    typ: Type, // typ because type is a keyword
    abilityIndices: []const []const u8,
    moveIndices: [4]u16,
    baseStats: Stats,
    level: u8,

    // battle stuff
    heldItem: []const u8,
    buffs: Buffs,
    currentHp: u16,

    nonVolatileStatus: NonVolatileStatus, // only one at a time
    nonVolatileStatusTurn: u8,

    // non volatile status conditions
    volatileStatusFlags: VolatileStatusFlags,
    volatileStatusConditionData: std.ArrayList(VolatileStatusConditionData),

    lastUsedMoveIndex: u16, // for things like mimic, sketch, encore
};
