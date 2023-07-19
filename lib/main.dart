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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(onPressed: () {}, child: Text('test TextButton')),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          debugPrint("start test"),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      persistentFooterAlignment: AlignmentDirectional.lerp(
          AlignmentDirectional.centerStart,
          AlignmentDirectional.centerStart,
          1.0)!,
      persistentFooterButtons: [
        FloatingActionButton(
          onPressed: () => {
            debugPrint("start test"),
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () => {
            debugPrint("start test"),
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add_a_photo),
        )
      ],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.flight_land),
              title: Text("Trix's airplane"),
              trailing: Icon(Icons.add),
              enableFeedback: false,
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
