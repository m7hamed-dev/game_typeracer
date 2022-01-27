const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const getSentence = require('./api/getSentence');
const gameModel = require('./models/Game');
// create server
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require('socket.io')(server);
// middle ware
app.use(express.json());
// db config
const db = 'mongodb+srv://moh:moh123@cluster0.jc9hn.mongodb.net/myFirstDatabase?retryWrites=true&w=majority';

// listening to socket io events from the client ( flutter code ) 
io.on('connection', (socket) => {
    console.log('connection with so cket id ', socket.id);
    // on create game
    socket.on('create-game', async({ nickname }) => {
        try {
            let game = new gameModel();
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
            console.log('gameId = ', gameId);
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
    socket.on('join-game', async({ nickname, gameID }) => {
        try {
            if (!gameID.match(/^[0-9a-fA]{24}$/)) {
                socket.emit('notCorrectGame', 'Please Enter A valid Game ID');
                return;
            }
            let game = await gameModel.findById(gameID);
            //
            if (game.isJonin) {
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
    // timer listener
    socket.on('timer', async({ playerId, gameID }) => {
        let countDown = 5;
        let game = await gameModel.findById(gameID);
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
                    clearInterval(timerID);
                }
            }, 1000);
        }
    });
});

// 
mongoose.connect(db).then(() => {
    console.log('connection successfuly !!');
}).catch((e) => {
    console.log('Connection Error On ::: ', e);
});
// listen server
server.listen(port, '0.0.0.0', () => {
    console.log('server running on port ', port);
});