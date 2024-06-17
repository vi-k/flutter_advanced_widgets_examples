import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_widgets_examples/common/navigation_node.dart';

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomeScreen(title: 'Navigation'),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  static MyHomeScreenState of(
    BuildContext context, {
    bool listen = true,
  }) =>
      _MyHomeScreenInheritedWidget.of(context, listen: listen).controller;

  @override
  State<MyHomeScreen> createState() => MyHomeScreenState();
}

class MyHomeScreenState extends State<MyHomeScreen> {
  bool get isDark => _isDark;
  var _isDark = false;

  TimeOfDay get time => _time;
  var _time = TimeOfDay.fromDateTime(DateTime.now());
  set time(TimeOfDay value) {
    if (_time != value) {
      setState(() {
        _time = value;
      });
    }
  }

  void toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyHomeScreenInheritedWidget(
      controller: this,
      child: Theme(
        data: _isDark ? ThemeData.dark() : ThemeData.light(),
        child: const MediaQuery(
          data: MediaQueryData(
            alwaysUse24HourFormat: true,
          ),
          child: _Content(),

          // child: Navigator(
          //   pages: [
          //     MaterialPage(child: _Content()),
          //   ],
          // ),

          // child: NavigationNode(
          //   child: _Content(),
          // ),
        ),
      ),
    );
  }
}

class _MyHomeScreenInheritedWidget extends InheritedWidget {
  final MyHomeScreenState controller;

  const _MyHomeScreenInheritedWidget({
    required this.controller,
    required super.child,
  });

  static _MyHomeScreenInheritedWidget of(
    BuildContext context, {
    required bool listen,
  }) =>
      maybeOf(context, listen: listen) ??
      (throw Exception(
          '$_MyHomeScreenInheritedWidget not found in the context.'));

  static _MyHomeScreenInheritedWidget? maybeOf(
    BuildContext context, {
    required bool listen,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<
              _MyHomeScreenInheritedWidget>()
          : context
              .getInheritedWidgetOfExactType<_MyHomeScreenInheritedWidget>();

  @override
  bool updateShouldNotify(_MyHomeScreenInheritedWidget oldWidget) => true;
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    final controller = MyHomeScreen.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(controller.widget.title),
      ),
      body: Center(
        child: Text(controller.time.format(context)),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 1,
            onPressed: controller.toggleTheme,
            child: Icon(
              controller.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 2,
            onPressed: setNewTime,
            child: const Icon(Icons.access_time_outlined),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 3,
            onPressed: showTime,
            child: const Icon(Icons.chat),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 4,
            onPressed: duplicate,
            child: const Icon(Icons.copy),
          ),
        ],
      ),
    );
  }

  Future<void> setNewTime() async {
    final time = await showDialog<TimeOfDay>(
      context: context,
      barrierDismissible: true,
      useRootNavigator: false,
      builder: (context) => TimePickerDialog(
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      ),
    );

    if (time != null && mounted) {
      MyHomeScreen.of(context).time = time;
    }
  }

  void showTime() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _ShowTime(),
      ),
    );
  }

  void duplicate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomeScreen(title: 'Navigation 2'),
      ),
    );
  }
}

class _ShowTime extends StatelessWidget {
  const _ShowTime();

  @override
  Widget build(BuildContext context) {
    // final controller = MyHomeScreen.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).removePadding(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Show time'),
        ),
        body: Center(
          child: Text('time'),
          // child: Text(controller.time.format(context)),
        ),
      ),
    );
  }
}
