const std = @import("std");
const Monster = @import("monster.zig").Monster;

const Side = struct {
    party: [6]Monster,
    active: u8, // 0-6, 0 means none

    // effects and such
    spikes: ?u8,
    toxicSpikes: ?u8,
    stealthRock: ?u8,
    stickyWeb: ?u8,

    tailwind: ?u8,
    lightScreen: ?u8,
    reflect: ?u8,
    auroraVeil: ?u8,
    safeguard: ?u8,
    mist: ?u8,
    luckyChant: ?u8,
    wishMove: ?u8,

    craftyShield: bool,
    matBlock: bool,
    quickGuard: bool,
    wideGuard: bool,
    protected: bool, // set if protect/detect succeeds

    healingWishLunarDanceCountdown: ?u8,
    futureSightMove: ?u8,

    //  doom desire and perish song are at the monster level
};

const BattleState = struct {
    // 0 = idle, not started
    // 1 = waiting for moves/switches from both players
    // 2 = waiting for p1 switch (if p1's monster has fainted or used a switching move)
    // 3 = waiting for p2 switch (if p2's monster has fainted or used a switching move)
    // 4 = battle over
    status: u8,
    p1: Side,
    p2: Side,
    turn: u16,

    terrain: u8, // one at a time
    weather: u8,

    // rooms
    trickRoom: ?u8,
    magicRoom: ?u8,
    wonderRoom: ?u8,
    intenseGravity: ?u8,

    // TODO: more battle-wide effects if there are any
};

// if the battle hasn't started, player choices are used to determine the first active monsters
// if the battle has started, 0-3 are moves,  4-7 are moves

fn apply_choices(
    b: *BattleState,
    player_one_choice: u8,
    player_two_choice: u8,
) BattleState {
    std.debug.print("player one chose: {}\n", .{player_one_choice});
    std.debug.print("player two chose: {}\n", .{player_two_choice});

    if (b.*.status == 0) {
        b.*.party_one_active = player_one_choice;
        b.*.party_two_active = player_two_choice;
    }

    // handle switches
    // first, check for things that prevent switches
    var canSwitch = true;
    var faster = true;
    canSwitch = false;
    faster = false;
    std.debug.print("player one chose: {}\n", .{canSwitch});
    std.debug.print("player two chose: {}\n", .{faster});

    // moves
    // priority order

    // end turn damage/effects like poison, burn, future sight, perish song, etc

    // check for end of battle
    return b;
}
