import 'package:socket_io_client/socket_io_client.dart' as IO;

// singleton design patteren
class SocketClien {
  late IO.Socket socket;
  static SocketClien? _instance;
  //
  SocketClien._internal() {
    socket = IO.io('http://127.0.0.1:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }
  //
  static SocketClien get instance {
    _instance ??= SocketClien._internal();
    return _instance!;
  }
}
