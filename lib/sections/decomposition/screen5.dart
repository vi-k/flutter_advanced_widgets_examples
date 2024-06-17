import 'package:flutter/material.dart';

import '../../common/recolored_box.dart';

class Screen5 extends StatefulWidget {
  final String title;

  const Screen5({
    super.key,
    required this.title,
  });

  static Screen5State of(BuildContext context) => _Screen4InheritedModel.of(
        context,
        listen: false,
      ).controller;

  static String titleOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      _Screen4InheritedModel.of(
        context,
        listen: listen,
        aspect: _Aspects.title,
      ).title;

  static int counterOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      _Screen4InheritedModel.of(
        context,
        listen: listen,
        aspect: _Aspects.counter,
      ).counter;

  static bool darkThemeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      _Screen4InheritedModel.of(
        context,
        listen: listen,
        aspect: _Aspects.darkTheme,
      ).darkTheme;

  @override
  State<Screen5> createState() => Screen5State();
}

class Screen5State extends State<Screen5> {
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
    return _Screen4InheritedModel(
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

enum _Aspects { title, counter, darkTheme }

class _Screen4InheritedModel extends InheritedModel<_Aspects> {
  final Screen5State controller;
  final String title;
  final int counter;
  final bool darkTheme;

  _Screen4InheritedModel({
    required this.controller,
    required super.child,
  })  : title = controller.widget.title,
        counter = controller.counter,
        darkTheme = controller.darkTheme;

  static _Screen4InheritedModel of(
    BuildContext context, {
    required bool listen,
    _Aspects? aspect,
  }) =>
      maybeOf(context, listen: listen, aspect: aspect) ??
      (throw Exception('$_Screen4InheritedModel not found in the context.'));

  static _Screen4InheritedModel? maybeOf(
    BuildContext context, {
    required bool listen,
    _Aspects? aspect,
  }) =>
      listen
          ? InheritedModel.inheritFrom<_Screen4InheritedModel>(
              context,
              aspect: aspect,
            )
          : context.getInheritedWidgetOfExactType<_Screen4InheritedModel>();

  @override
  bool updateShouldNotify(_Screen4InheritedModel oldWidget) => true;

  @override
  bool updateShouldNotifyDependent(
    covariant _Screen4InheritedModel oldWidget,
    Set<_Aspects> dependencies,
  ) =>
      dependencies.contains(_Aspects.title) && title != oldWidget.title ||
      dependencies.contains(_Aspects.counter) && counter != oldWidget.counter ||
      dependencies.contains(_Aspects.darkTheme) &&
          darkTheme != oldWidget.darkTheme;
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
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
          Screen5.titleOf(context),
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
                child: Text('${Screen5.counterOf(context)}'),
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
              value: Screen5.darkThemeOf(context),
              onChanged: (value) => Screen5.of(context).toggleTheme(value),
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
    return Theme(
      data: Screen5.darkThemeOf(context) ? ThemeData.dark() : ThemeData.light(),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () => Screen5.of(context).reset(),
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          onPressed: () => Screen5.of(context).incrementCounter(),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
