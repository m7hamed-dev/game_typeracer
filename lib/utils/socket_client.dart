import 'package:socket_io_client/socket_io_client.dart' as IO;

// singleton design patteren
class SocketClient {
  late IO.Socket socket;
  static SocketClient? _instance;
  //
  SocketClient._internal() {
    socket = IO.io('http://192.168.30.225:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }
  //
  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
