const std = @import("std");
const Monster = @import("monster.zig").Monster;

const BattleState = struct {
    turn: u16,
    party_one_active: u4, // 0-5
    party_two_active: u4, // 0-5
    party_one: [6]Monster,
    party_two: [6]Monster,
    terrain: []const u8,
    weather: []const u8,
    room: []const u8,
};

fn apply_moves(
    b: *BattleState,
    player_one_choice: u32,
    player_two_choice: u32,
) BattleState {
    std.debug.print(player_one_choice);
    std.debug.print(player_two_choice);

    b.*.turn += 1;

    // switches

    // moves

    return b;
}
