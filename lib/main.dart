import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

void main() {
//  runApp(MyApp());
  final tempDecoder = TempDecoder();
  ServerSocket.bind('127.0.0.1', 8080).then((serverSocket) {
    print('connected!');
    serverSocket.listen((event) {
      event.transform(tempDecoder).listen((event) {
        print('event => $event');
      });
    });
  });
}

class TempDecoder extends Converter<Uint8List, String> {
  @override
  String convert(Uint8List input) {
    print('input => $input');
    return "";
  }

  @override
  Sink<Uint8List> startChunkedConversion(Sink<String> sink) =>
      new TempSink(sink);
}

class TempSink extends ChunkedConversionSink<Uint8List> {
  final Sink<String> _sink;

  TempSink(this._sink);

  @override
  void add(Uint8List chunk) {
    var decode = utf8.decode(chunk);
    print('decode => $chunk');
    // TODO: implement add
  }

  @override
  void close() {
    print('closed!');
    // TODO: implement close
  }
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
