import 'dart:math';

import 'package:flutter/material.dart';

class StatelessApp extends StatelessWidget {
  const StatelessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomeScreen(
        title: 'Stateless with state',
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
  var _counter = 1;

  void _incerementCounter() {
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
      body: Center(
        child: MyWidget('MyWidget $_counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incerementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Stateless widget with state!
abstract class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  StatelessElement createElement() =>
      MyStatelessElement(this);

  MyState createMyState();

  @override
  Widget build(BuildContext context) =>
      throw UnimplementedError();
}

/// Element for [MyStatelessWidget].
class MyStatelessElement extends StatelessElement {
  MyStatelessElement(MyStatelessWidget widget)
      : state = widget.createMyState(),
        super(widget) {
    state._widget = widget;
    state._context = this;
    state.initMyState();
  }

  final MyState<MyStatelessWidget> state;

  @override
  void update(MyStatelessWidget newWidget) {
    state._widget = newWidget;
    super.update(newWidget);
  }

  @override
  void unmount() {
    state.disposeMyState();
    super.unmount();
  }

  @override
  Widget build() => state.myBuild(this);
}

/// State for [MyStatelessWidget].
abstract class MyState<T extends MyStatelessWidget> {
  T get widget => _widget!;
  T? _widget;

  BuildContext get context => _context!;
  BuildContext? _context;

  void initMyState() {}

  void disposeMyState() {}

  Widget myBuild(BuildContext context);
}

/// [MyStatelessWidget] usage example.
class MyWidget extends MyStatelessWidget {
  final String text;

  const MyWidget(
    this.text, {
    super.key,
  });

  @override
  MyState<MyWidget> createMyState() => _MyWidgetState();
}

class _MyWidgetState extends MyState<MyWidget> {
  static final _random = Random();

  late final Color _color;

  @override
  void initMyState() {
    super.initMyState();

    _color = Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  void disposeMyState() {
    // ...
    super.disposeMyState();
  }

  @override
  Widget myBuild(BuildContext context) {
    return Container(
      color: _color,
      padding: const EdgeInsets.all(10),
      child: Text(widget.text),
    );
  }
}
