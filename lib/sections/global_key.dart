import 'dart:math';

import 'package:flutter/material.dart';

class GlobalKeyApp extends StatelessWidget {
  const GlobalKeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomeScreen(title: 'Global key'),
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
  static const _count = 3;
  var _index = 0;

  // final _globalKey = GlobalKey();
  // final _globalKey = GlobalKey<_MyWidgetState>();

  void _move() {
    setState(() {
      _index++;
      if (_index >= _count) {
        _index = 0;
      }
    });
  }

  void _refresh() {
    // final state = _globalKey.currentState;
    // state?.changeColor();

    //   // var counter = 0;
    //   // _globalKey.currentContext
    //   //     ?.visitAncestorElements((parent) {
    //   //   if (parent.widget is MyHomeScreen) {
    //   //     return false;
    //   //   }
    //   //   counter++;
    //   //   return true;
    //   // });
    //   // print(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < _count; i++)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  width: 200,
                  height: 100,
                  child: Center(
                    child: _index != i
                        ? null
                        : const _MyWidget(),
                    // : _MyWidget(key: _globalKey),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _move,
            child: const Icon(Icons.arrow_downward),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _refresh,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class _MyWidget extends StatefulWidget {
  const _MyWidget({super.key});

  @override
  State<_MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<_MyWidget>
    with SingleTickerProviderStateMixin {
  static const double _size = 50;
  static final _random = Random();

  late Color _color;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _color = _randomColor();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void changeColor() {
    setState(() {
      _color = _randomColor();
    });
  }

  static Color _randomColor() => Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _animationController,
      builder: (context, value, _) {
        return Container(
          height: _size,
          width: _size / 2 + _size / 2 * value * 4,
          color: _color,
        );
      },
    );
  }
}
