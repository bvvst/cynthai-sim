// unlike the representation to the neural network
// this does not one-hot encode unique moves,
// instead these are applied in the battle logic (or via the unique effects i haven't decided yet)

pub const Move = struct {
    index: u8,
    kind: []const u8, // kind instead of type because type is a keyword

    physical: bool,
    special: bool,

    power: u16,
    accuracy: u8,

    totalPp: u8,
    currentPp: u8,

    paralysisAccuracy: u8,
    burnAccuracy: u8,
    freezeAccuracy: u8,
    sleepAccuracy: u8,
    poisonAccuracy: u8,
    confusionAccuracy: u8,
    flinchAccuracy: u8,
    recoilAccuracy: u8,
    paralysisChance: u8,

    // review this usage against battle logic with chatgpt
    uniqueEffectIndices: []const u8,
};
