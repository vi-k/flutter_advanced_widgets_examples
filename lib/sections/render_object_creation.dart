import 'dart:math';

import 'package:flutter/material.dart';

class RenderObjectCreationApp extends StatelessWidget {
  const RenderObjectCreationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomeScreen(title: 'Render object. Creation'),
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
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Clock(
              time: DateTime.now(),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text('abc'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class Clock extends LeafRenderObjectWidget {
  const Clock({
    super.key,
    required this.time,
  });

  final DateTime time;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderClock(time: time);

  @override
  void updateRenderObject(
    BuildContext context,
    RenderClock renderObject,
  ) {
    renderObject.time = time;
  }
}

class RenderClock extends RenderBox {
  RenderClock({
    required DateTime time,
  }) : _time = time;

  DateTime get time => _time;
  DateTime _time;
  set time(DateTime value) {
    if (_time != value) {
      _time = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    size = constraints.constrain(const Size.square(200));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas
      ..save()
      ..translate(offset.dx + size.width / 2, offset.dy + size.height / 2);

    final clockRadius = size.shortestSide / 2;
    final hourMarkerRadius = clockRadius / 20;
    final minuteMarkerLength = hourMarkerRadius;
    final minuteMarkerWidth = minuteMarkerLength / 2;
    final innerClockRadius = clockRadius - hourMarkerRadius * 2;

    // Циферблат.
    for (var i = 0; i < 60; i++) {
      context.canvas
        ..save()
        ..rotate(_minuteToRadians(i.toDouble()));

      if (i % 5 == 0) {
        context.canvas.drawCircle(
          Offset(clockRadius - hourMarkerRadius, 0),
          hourMarkerRadius,
          Paint()..color = Colors.blueGrey,
        );
      } else {
        context.canvas.drawRect(
          Rect.fromLTWH(
            clockRadius - (hourMarkerRadius * 2 - minuteMarkerLength / 2),
            -minuteMarkerWidth / 2,
            minuteMarkerLength,
            minuteMarkerWidth,
          ),
          Paint()..color = Colors.blueGrey.shade300,
        );
      }

      context.canvas.restore();
    }

    final second = time.second + time.millisecond / 1000;
    final minute = time.minute + second / 60;
    final hour = time.hour + minute / 60;

    // Часовая стрелка.
    final hourHandLength = innerClockRadius * 0.6;
    final hourHandIndent = innerClockRadius * 0.1;
    final hourHandWidth = hourMarkerRadius * 2;

    context.canvas
      ..save()
      ..rotate(_hourToRadians(hour))
      ..drawRect(
        Rect.fromLTWH(
          -hourHandIndent,
          -hourHandWidth / 2,
          hourHandIndent + hourHandLength,
          hourHandWidth,
        ),
        Paint()..color = Colors.black,
      )
      ..restore();

    // Минутная стрелка.
    final minuteHandLength = innerClockRadius * 0.95;
    final minuteHandIndent = innerClockRadius * 0.15;
    final minuteHandWidth = hourHandWidth / 2;

    context.canvas
      ..save()
      ..rotate(_minuteToRadians(minute))
      ..drawRect(
        Rect.fromLTWH(
          -minuteHandIndent,
          -minuteHandWidth / 2,
          minuteHandIndent + minuteHandLength,
          minuteHandWidth,
        ),
        Paint()..color = Colors.black,
      )
      ..restore();

    // Секундная стрелка.
    final secondHandLength = innerClockRadius * 0.98;
    final secondHandIdent = innerClockRadius * 0.2;
    final secondHandWidth = minuteMarkerWidth;

    context.canvas
      ..save()
      ..rotate(_minuteToRadians(second))
      ..drawRect(
        Rect.fromLTWH(
          -secondHandIdent,
          -secondHandWidth / 2,
          secondHandIdent + secondHandLength,
          secondHandWidth,
        ),
        Paint()..color = Colors.red,
      )
      ..restore();

    context.canvas
      ..drawCircle(
        Offset.zero,
        secondHandWidth / 2,
        Paint()..color = Colors.white,
      )
      ..restore();
  }

  double _hourToRadians(double hour) => pi * 2 * hour / 12 - pi / 2;

  double _minuteToRadians(double minute) => pi * 2 * minute / 60 - pi / 2;
}
