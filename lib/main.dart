import 'dart:io';
import 'dart:math';

import 'package:udp/udp.dart';

main() async {
  final list = [0, -1, -1, 0, -2, -2, -2, -2, -3, -3, -3, -3, 18, 52, 86, 120];
  final guid = Random.secure().nextInt(2 ^ 63 - 1);
  var sender = await UDP.bind(Endpoint.any(port: Port(65000)));
  var dataLength = await sender.send(
      "Hello World!".codeUnits, Endpoint.broadcast(port: Port(65001)));
  stdout.write("$dataLength bytes sent.");
  var receiver = await UDP.bind(Endpoint.loopback(port: Port(65002)));
  await receiver.listen((datagram) {
    var str = String.fromCharCodes(datagram.data);
    stdout.write(str);
  }, timeout: Duration(seconds: 20));
//  final server = RawDatagramSocket.bind(InternetAddress.anyIPv4, 8080);
//  server.then((RawDatagramSocket socket) {
//    print('Datagram socket ready to receive');
//    print('${socket.address.address}:${socket.port}');
//    socket.listen((RawSocketEvent e) {
//      Datagram d = socket.receive();
//      if (d == null) {
//        return;
//      }
//      final data = d.data;
//      final byteBloc = ByteBloc(data);
//      var packetId = byteBloc.readInt8();
//      print(packetId);
//      final pingTime = byteBloc.readInt64();
//      final magic = byteBloc.readInt8List(16);
//      if (ListEquality().equals(magic, list)) {
//        final serverinf =
//            "MCPE;Dedicated Server;407;1.16.0;0;10;$guid;Bedrock level;Survival;1;19132;19133;";
//        final packetLength = 35 + serverinf.length;
//        final byteBloc = ByteBloc.empty(packetLength);
//        byteBloc.writeInt8(0x1c);
//        byteBloc.writeInt64(pingTime);
//        byteBloc.writeInt64(guid);
//        byteBloc.writeInt8List(magic);
//        byteBloc.writeInt32(packetLength);
//        List<int> encode = utf8.encode(serverinf);
//        byteBloc.writeInt8List(Int8List.fromList(encode));
//        var send = socket.send(byteBloc.list, d.address, d.port);
//        print('sent: $send');
//      }
//    });
//  });
}
