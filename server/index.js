const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const getSentence = require('./api/getSentence');
const _GameModel = require('./models/Game');
// create server
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require('socket.io')(server);
// middle ware
app.use(express.json());
// db config
const db = 'mongodb+srv://moh:moh123@cluster0.jc9hn.mongodb.net/myFirstDatabase?retryWrites=true&w=majority';
//
const startGameClock = async(GAMEID) => {
        //
        let _game = await _GameModel.findById(GAMEID);
        //
        _game.startTime = new Date().getTime();
        //
        _game = await _game.save();
        //
        let _time = 120;
        //
        let timerID = setInterval(((function getIntervalFunc() {
            if (_time >= 0) {
                const _timeFormat = calculateTime(_time);
                io.to(GAMEID).emit('timer', {
                    countDown: _timeFormat,
                    msg: 'Timer Remaining'
                });
                console.log('time ', _time);
                _time--;
            }
            return getIntervalFunc;
        })()), 1000);
    }
    //
const calculateTime = (yourTime) => {
        let _min = Math.floor(yourTime / 60);
        let _sec = yourTime % 60;
        return `${_min}:${_sec < 10 ? "0" + _sec : _sec}`;
    }
    // listening to socket io events from the client ( flutter code ) 
io.on('connection', (socket) => {
    console.log('client connection with socket id ', socket.id);
    // on create game
    socket.on('create-game', async({ nickname }) => {
        try {
            let game = new _GameModel();
            const sentence = await getSentence();
            game.words = sentence;
            let player = {
                socketID: socket.id,
                nickname,
                isPartyLeader: true
            };
            game.players.push(player);
            game = await game.save();
            const gameId = game._id.toString();
            console.log('created succussfuly !! ', 'gameId = ', gameId);
            socket.join(gameId);
            // client input -> client -> server -> mongoDB -> server -> client
            // io to means update to single id
            io.to(gameId).emit('updateGame', game);
            //
        } catch (error) {
            console.log('error on create game ', error);
        }
    });
    // on join game
    socket.on('join-game', async({ gameID, nickname }) => {
        try {
            if (!gameID.match(/^[0-9a-fA]{24}$/)) {
                socket.emit('notCorrectGame', 'Please Enter A valid Game ID');
                return;
            }
            let game = await _GameModel.findById(gameID);
            // console.log('game :: ', game);
            //
            if (game == null) {
                socket.emit('notCorrectGame', 'The Game is in progress , Please Try again !!');
                return;
            }
            if (game.isJoin) {
                const id = game._id.toString();
                let _player = {
                    nickname,
                    socketID: socket.id,
                };
                socket.join(id);
                game.players.push(_player);
                game = await game.save();
                io.to(gameID).emit('updateGame', game);
            } else {
                socket.emit('notCorrectGame', 'The Game is in progress , Please Try again !!');
            }
        } catch (error) {
            console.log(error);
        }
    });

    socket.on('userInput', async({ userInput, gameID }) => {
        // in js === meaning equal
        let game = await _GameModel.findById(gameID);
        if (!game.isJoin && !game.isOver) {
            let player = game.players.find((_singlePlayer) => _singlePlayer.socketID === socket.id);

            if (game.words[player.currentWordIndex] === userInput.trim()) {
                // go to next index
                player.currentWordIndex = player.currentWordIndex + 1;
                if (player.currentWordIndex !== game.words.length) {
                    game = await game.save();
                    io.to(gameID).emit('updateGame', game);
                }
            }
        }

    });

    // timer listener
    socket.on('timer', async({ playerId, gameID }) => {
        let countDown = 5;
        let game = await _GameModel.findById(gameID);
        // get one playe by pass player id
        let player = game.players.id(playerId);
        // console.log('player : ', player, ' game ', game);
        //
        if (player.isPartyLeader) {
            console.log('player.isPartyLeader ', player.isPartyLeader);
            let timerID = setInterval(async() => {
                if (countDown >= 0) {
                    //
                    io.to(gameID).emit('timer', {
                        countDown,
                        msg: 'game starting ...'
                    });
                    console.log('countDown :::: ', countDown);
                    countDown--;
                } else {
                    game.isJoin = false;
                    game = await game.save();
                    io.to(gameID).emit('updateGame', game);
                    startGameClock(gameID);
                    clearInterval(timerID);
                }
            }, 1000);
        }
    });
});

//  mongo part
mongoose.connect(db).then(() => {
    console.log('mongoose DB connection successfuly !!');
}).catch((e) => {
    console.log('Connection Error On ::: ', e);
});
// listen server
server.listen(port, '0.0.0.0', () => {
    console.log('server running on port ', port);
});