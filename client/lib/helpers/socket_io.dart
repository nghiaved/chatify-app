import 'package:client/services/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

io.Socket socket = io.io(
  urlServer,
  io.OptionBuilder().setTransports(['websocket']).build(),
);
