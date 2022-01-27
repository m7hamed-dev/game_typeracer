import 'package:flutter/material.dart';
import 'package:game_typeracer/utils/socket_methods.dart';
import 'package:game_typeracer/views/input.dart';
import 'package:game_typeracer/widgets/btn.dart';

class CreateRoomView extends StatefulWidget {
  const CreateRoomView({Key? key}) : super(key: key);

  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends State<CreateRoomView> {
  final _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    _socketMethods.updateGameListener(context);
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateRoomView page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Create Room'),
            const SizedBox(height: 20.0),
            Input(
              hint: 'enter nickname',
              controller: _nameController,
              onChange: (value) {},
            ),
            Btn(
              child: const Text('Create'),
              onPressed: () =>
                  _socketMethods.createGame(_nameController.text.trim()),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }
}
