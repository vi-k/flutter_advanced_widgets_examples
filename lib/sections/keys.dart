import 'dart:math';

import 'package:flutter/material.dart';

class KeysApp extends StatelessWidget {
  const KeysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomeScreen(title: 'Keys'),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class Item {
  final int id;
  final int data;

  Item(this.id, this.data);

  @override
  int get hashCode => Object.hash(id, data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item && id == other.id && data == other.data;
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  static const _count = 3;
  static final _random = Random();

  late List<Item> _items;
  // late List<(UniqueKey, Item)> _itemsWithKeys = [];

  @override
  void initState() {
    super.initState();

    _items = List.generate(
      _count,
      (i) => Item(i + 1, _generateData()),
    );
    // _items.add(_items[0]);

    // for (final item in _items) {
    //   _itemsWithKeys.add((UniqueKey(), item));
    // }
  }

  void _updateData() {
    setState(() {
      _items = _randomSort(_items);
      // _items = _recreateItems(_items);
      // _items = _updateItemsData(_items);
      // _itemsWithKeys = _randomSort(_itemsWithKeys);
    });
  }

  static int _generateData() => _random.nextInt(100);

  static List<T> _randomSort<T>(List<T> items) =>
      List.of(items)
        ..sort((a, b) => _random.nextBool() ? 1 : -1);

  static List<Item> _recreateItems(List<Item> list) =>
      list.map((item) => Item(item.id, item.data)).toList();

  static List<Item> _updateItemsData(List<Item> list) =>
      list
          .map((item) => Item(item.id, _generateData()))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final item in _items)
            _RandomColoredBox(
              // key: ObjectKey(item),
              // key: ValueKey(item),
              // key: ValueKey(item.id),
              // key: UniqueKey(),
              child: Text('#${item.id}: ${item.data}'),
            ),
          // for (final (key, item) in _itemsWithKeys)
          //   _RandomColoredBox(
          //     key: key,
          //     child: Text('#${item.id}: ${item.data}'),
          //   ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _RandomColoredBox extends StatefulWidget {
  final Widget child;

  const _RandomColoredBox({
    super.key,
    required this.child,
  });

  @override
  State<_RandomColoredBox> createState() =>
      _RandomColoredBoxState();
}

class _RandomColoredBoxState
    extends State<_RandomColoredBox> {
  static final _random = Random();

  late final Color _color;

  @override
  void initState() {
    super.initState();

    _color = Color.fromARGB(
      255,
      128 + _random.nextInt(128),
      128 + _random.nextInt(128),
      128 + _random.nextInt(128),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _color,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: widget.child,
      ),
    );
  }
}
