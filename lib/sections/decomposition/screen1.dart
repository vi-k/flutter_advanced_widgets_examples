import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  final String title;

  const Screen1({
    super.key,
    required this.title,
  });

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
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
            Container(
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
            ),
            const SizedBox(height: 10),
            Padding(
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
                      style: Theme.of(context).textTheme.titleMedium!.apply(
                          color: Theme.of(context).colorScheme.onPrimaryFixed),
                      child: Text('$_counter'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
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
            ),
            const SizedBox(height: 10),
            Theme(
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
            ),
          ],
        ),
        floatingActionButton: Row(
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
        ),
      ),
    );
  }
}
