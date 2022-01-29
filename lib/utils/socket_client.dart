import 'package:socket_io_client/socket_io_client.dart' as IO;

// singleton design patteren
class SocketClient {
  //
  late IO.Socket socket;
  static SocketClient? _instance;
  static const ipAddress = '192.168.128.225';
  //
  SocketClient._internal() {
    socket = IO.io('http://$ipAddress:3000', <String, dynamic>{
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
