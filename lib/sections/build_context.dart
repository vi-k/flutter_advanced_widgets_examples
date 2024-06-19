import 'package:flutter/material.dart';

void main() {
  runApp(const BuildContextApp());
}

class BuildContextApp extends StatelessWidget {
  const BuildContextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomeScreen(
        title: 'BuildContext',
      ),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  var _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: DefaultTextStyle(
      //   style: DefaultTextStyle.of(context)
      //       .style
      //       .copyWith(fontSize: 40),
      body: Center(
        child: Text('$_counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
