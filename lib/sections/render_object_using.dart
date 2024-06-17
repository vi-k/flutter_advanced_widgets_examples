import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderObjectUsingApp extends StatelessWidget {
  const RenderObjectUsingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomeScreen(title: 'Render object. Using'),
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
  var _counter = 0;
  Key? _selected;

  void _refresh() {
    setState(() {
      _counter++;
    });
  }

  void _select(Key? key) {
    setState(() {
      _selected = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            key: ValueKey('SingleChildScrollView#$_counter'),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  for (var i = 0; i < 10; i++) ...[
                    const SizedBox(width: 10),
                    if (_selected == ValueKey(i))
                      FilledButton(
                        key: ValueKey(i),
                        onPressed: () {
                          _select(null);
                        },
                        child: Text('$i'),
                      )
                    else
                      ElevatedButton(
                        key: ValueKey(i),
                        onPressed: () {
                          _select(ValueKey(i));
                        },
                        child: Text('$i'),
                      ),
                  ],
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          AutoScrollBand(
            key: ValueKey('AutoScrollBand#$_counter'),
            selected: _selected,
            children: [
              for (var i = 0; i < 10; i++)
                if (_selected == ValueKey(i))
                  FilledButton(
                    key: ValueKey(i),
                    onPressed: () {},
                    child: Text('$i'),
                  )
                else
                  ElevatedButton(
                    key: ValueKey(i),
                    onPressed: () {
                      _select(ValueKey(i));
                    },
                    child: Text('$i'),
                  ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text('${_selected ?? 'nothing'}'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AutoScrollBand extends StatefulWidget {
  const AutoScrollBand({
    super.key,
    this.selected,
    required this.children,
  });

  final List<Widget> children;
  final Key? selected;

  @override
  State<AutoScrollBand> createState() => _AutoScrollBandState();
}

class _AutoScrollBandState extends State<AutoScrollBand> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final selected = widget.selected;
    if (selected != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _goto(selected));
    }
  }

  void _goto(Key key) {
    final row = _findRow(context)!;
    Element? selected;

    row.visitChildElements((element) {
      if (element.widget.key == key) {
        selected = element;
      }
    });

    if (selected != null) {
      final renderSelected = selected!.findRenderObject();
      if (renderSelected is RenderBox) {
        final parentData = renderSelected.parentData;
        if (parentData is BoxParentData) {
          final offset = parentData.offset.dx -
              (_scrollController.position.viewportDimension -
                      renderSelected.size.width) /
                  2;
          _scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.ease,
          );
        }
      }
    }
  }

  MultiChildRenderObjectElement? _findRow(BuildContext context) {
    MultiChildRenderObjectElement? result;

    context.visitChildElements((element) {
      if (element is MultiChildRenderObjectElement) {
        result = element;
      } else {
        result = _findRow(element);
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            for (final child in widget.children) ...[
              const SizedBox(width: 10),
              child,
            ],
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
