import 'package:flutter/material.dart';
import 'package:flutter_advanced_widgets_examples/common/recolored_box.dart';

class Screen4 extends StatefulWidget {
  final String title;

  const Screen4({
    super.key,
    required this.title,
  });

  static Screen4State of(
    BuildContext context, {
    bool listen = true,
  }) =>
      _Screen4InheritedWidget.of(context, listen: listen).controller;

  @override
  State<Screen4> createState() => Screen4State();
}

class Screen4State extends State<Screen4> {
  var counter = 0;
  var darkTheme = false;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void reset() {
    setState(() {
      counter = 0;
    });
  }

  void toggleTheme(bool value) {
    setState(() {
      darkTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Screen4InheritedWidget(
      controller: this,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Title(),
              SizedBox(height: 10),
              _Counter(),
              SizedBox(height: 10),
              _ThemeSwitcher(),
              SizedBox(height: 10),
              _ThemeExample(),
            ],
          ),
          floatingActionButton: _Actions(),
        ),
      ),
    );
  }
}

class _Screen4InheritedWidget extends InheritedWidget {
  final Screen4State controller;

  const _Screen4InheritedWidget({
    required this.controller,
    required super.child,
  });

  static _Screen4InheritedWidget of(
    BuildContext context, {
    required bool listen,
  }) =>
      maybeOf(context, listen: listen) ??
      (throw Exception('$_Screen4InheritedWidget not found in the context.'));

  static _Screen4InheritedWidget? maybeOf(
    BuildContext context, {
    required bool listen,
  }) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_Screen4InheritedWidget>()
          : context.getInheritedWidgetOfExactType<_Screen4InheritedWidget>();

  @override
  bool updateShouldNotify(_Screen4InheritedWidget oldWidget) => true;
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final controller = Screen4.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .apply(color: Theme.of(context).colorScheme.onPrimary),
        child: Text(
          controller.widget.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter();

  @override
  Widget build(BuildContext context) {
    final controller = Screen4.of(context);

    return RecoloredBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text('Counter:'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: Theme.of(context).colorScheme.onPrimaryFixed),
                child: Text('${controller.counter}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher();

  @override
  Widget build(BuildContext context) {
    final controller = Screen4.of(context);

    return RecoloredBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text('Dark theme for example:'),
            ),
            Switch.adaptive(
              value: controller.darkTheme,
              onChanged: controller.toggleTheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeExample extends StatelessWidget {
  const _ThemeExample();

  @override
  Widget build(BuildContext context) {
    final controller = Screen4.of(context);

    return Theme(
      data: controller.darkTheme ? ThemeData.dark() : ThemeData.light(),
      child: Builder(builder: (context) {
        return Material(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Text('Theme example'),
          ),
        );
      }),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    final controller = Screen4.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: controller.reset,
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          onPressed: controller.incrementCounter,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
