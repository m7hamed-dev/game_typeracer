const mongoose = require('mongoose');
const playerSchema = mongoose.Schema({
    nickname: {
        type: String
    },
    currentWordIndex: {
        type: Number,
        default: 0
    },
    // WPM word per minute
    WPM: {
        type: Number,
        default: -1
    },
    socketID: {
        type: String
    },
    isPartyLeader: {
        type: Boolean,
        default: false
    },
});

// set playerSchema global
module.exports = playerSchema;