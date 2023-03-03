import 'package:flutter/material.dart';
import 'package:liveness/liveness_platform_interface.dart';
import 'dio_mtls.dart';
import 'pinging.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String content = "";

  void _incrementCounter() {
    // fetchDio().then((value) => {handleContent(value)});

    // fetchDio();
    //fetchDioWithCert();

    // getDioTls().then((value) => {
    //       // getDiomTls().then((value) => {
    //       handleContent(value)
    //     });

    LivenessPlatform.instance.startLiveness().then(
        (value) => handleContent("face recognition result:${value ?? ""}"));
  }

  void handleContent(String result) {
    setState(() {
      _counter++;
      content = "$result\n$content";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'get message from url:',
            ),
            Text(
              '$_counter \n $content',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
