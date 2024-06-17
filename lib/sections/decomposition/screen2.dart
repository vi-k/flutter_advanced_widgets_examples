import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  final String title;

  const Screen2({
    super.key,
    required this.title,
  });

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
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
            _buildTitle(),
            const SizedBox(height: 10),
            _buildCounter(),
            const SizedBox(height: 10),
            _buildThemeSwitcher(),
            const SizedBox(height: 10),
            _buildThemeExample(),
          ],
        ),
        floatingActionButton: _buildActions(),
      ),
    );
  }

  Widget _buildTitle() => Container(
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
            widget.title,
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget _buildCounter() => Padding(
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

  Widget _buildThemeSwitcher() {
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
            value: _darkTheme,
            onChanged: _toggleTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeExample() {
    return Theme(
      data: _darkTheme ? ThemeData.dark() : ThemeData.light(),
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

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: _reset,
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 10),
        FloatingActionButton(
          onPressed: _incrementCounter,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
