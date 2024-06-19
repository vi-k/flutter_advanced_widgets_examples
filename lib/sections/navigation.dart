import 'package:flutter/material.dart';

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

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
        title: 'Navigation',
      ),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  static MyHomeScreenState of(BuildContext context) =>
      _MyHomeScreenInheritedWidget.of(context,
              listen: false)
          .controller;

  static String titleOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      _MyHomeScreenInheritedWidget.of(
        context,
        listen: listen,
        aspect: _Aspects.title,
      ).title;

  static bool someValueOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      _MyHomeScreenInheritedWidget.of(
        context,
        listen: listen,
        aspect: _Aspects.someValue,
      ).someValue;

  @override
  State<MyHomeScreen> createState() => MyHomeScreenState();
}

class MyHomeScreenState extends State<MyHomeScreen> {
  bool get someValue => _someValue;
  var _someValue = false;

  void changeSomeValue(bool value) {
    if (_someValue != value) {
      setState(() {
        _someValue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _MyHomeScreenInheritedWidget(
      controller: this,
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyHomeScreen.titleOf(context)),
      ),
      body: const Center(
        child: SomeValue(),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
            onPressed: () {
              MyHomeScreen.someValueOf(context);
              showOtherScreen(context);
            },
            child: const Text('Other screen'),
          ),
          const SizedBox(width: 10),
          FilledButton(
            onPressed: () {
              duplicate(context);
            },
            child: const Text('Duplicate'),
          ),
        ],
      ),
    );
  }

  void showOtherScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyOtherScreen(),
      ),
    );
  }

  void duplicate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const MyHomeScreen(title: 'Navigation 2'),
      ),
    );
  }
}

enum _Aspects { title, someValue }

class _MyHomeScreenInheritedWidget
    extends InheritedModel<_Aspects> {
  _MyHomeScreenInheritedWidget({
    required this.controller,
    required super.child,
  })  : title = controller.widget.title,
        someValue = controller.someValue;

  final MyHomeScreenState controller;
  final String title;
  final bool someValue;

  static _MyHomeScreenInheritedWidget of(
    BuildContext context, {
    required bool listen,
    _Aspects? aspect,
  }) =>
      maybeOf(
        context,
        listen: listen,
        aspect: aspect,
      ) ??
      (throw Exception(
        '$_MyHomeScreenInheritedWidget not found in the context.',
      ));

  static _MyHomeScreenInheritedWidget? maybeOf(
    BuildContext context, {
    required bool listen,
    _Aspects? aspect,
  }) =>
      listen
          ? InheritedModel.inheritFrom<
              _MyHomeScreenInheritedWidget>(
              context,
              aspect: aspect,
            )
          : context.getInheritedWidgetOfExactType<
              _MyHomeScreenInheritedWidget>();

  @override
  bool updateShouldNotify(
          _MyHomeScreenInheritedWidget oldWidget) =>
      true;

  @override
  bool updateShouldNotifyDependent(
          _MyHomeScreenInheritedWidget oldWidget,
          Set<_Aspects> dependencies) =>
      dependencies.contains(_Aspects.title) &&
          title != oldWidget.title ||
      dependencies.contains(_Aspects.someValue) &&
          someValue != oldWidget.someValue;
}

class SomeValue extends StatelessWidget {
  const SomeValue({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Some value: '),
        Switch.adaptive(
          value: MyHomeScreen.someValueOf(context),
          onChanged: (value) {
            MyHomeScreen.of(context).changeSomeValue(value);
          },
        ),
      ],
    );
  }
}

class MyOtherScreen extends StatelessWidget {
  const MyOtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other screen'),
      ),
      body: const Center(
        child: SomeValue(),
      ),
    );
  }
}
