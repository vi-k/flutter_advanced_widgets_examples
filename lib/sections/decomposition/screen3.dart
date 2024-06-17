import 'package:flutter/material.dart';

class Screen3 extends StatefulWidget {
  final String title;

  const Screen3({
    super.key,
    required this.title,
  });

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  var _counter = 0;
  var _darkTheme = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  void _toggleTheme(bool value) {
    setState(() {
      _darkTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Title(title: widget.title),
            const SizedBox(height: 10),
            _Counter(counter: _counter),
            const SizedBox(height: 10),
            _ThemeSwitcher(
              darkTheme: _darkTheme,
              onChange: _toggleTheme,
            ),
            const SizedBox(height: 10),
            _ThemeExample(darkTheme: _darkTheme),
          ],
        ),
        floatingActionButton: _Actions(
          onReset: _reset,
          onIncrement: _incrementCounter,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
  });

  final String title;

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
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter({
    required int counter,
  }) : _counter = counter;

  final int _counter;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: Text('$_counter'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher({
    required this.darkTheme,
    required this.onChange,
  });

  final bool darkTheme;
  final void Function(bool value) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text('Dark theme for example:'),
          ),
          Switch.adaptive(
            value: darkTheme,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}

class _ThemeExample extends StatelessWidget {
  const _ThemeExample({
    required this.darkTheme,
  });

  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme ? ThemeData.dark() : ThemeData.light(),
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
  const _Actions({
    required this.onReset,
    required this.onIncrement,
  });

  final void Function() onReset;
  final void Function() onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: onReset,
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          onPressed: onIncrement,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
