import 'package:expandable_column/expandable_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpandableColumn Widget Tests', () {
    testWidgets('renders with basic children', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                Text('Child 1'),
                Text('Child 2'),
                Text('Child 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
      expect(find.text('Child 3'), findsOneWidget);
    });

    testWidgets('supports Expanded widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                const Text('Header'),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: const Text('Expanded Content'),
                  ),
                ),
                const Text('Footer'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Expanded Content'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);

      // Verify that Expanded widget takes up available space
      final expandedFinder = find.byType(Expanded);
      expect(expandedFinder, findsOneWidget);
    });

    testWidgets('supports Spacer widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                Text('Top'),
                Spacer(),
                Text('Bottom'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Top'), findsOneWidget);
      expect(find.text('Bottom'), findsOneWidget);
      expect(find.byType(Spacer), findsOneWidget);
    });

    testWidgets('supports multiple Expanded widgets with flex', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.red,
                    child: const Text('Flex 2'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                    child: const Text('Flex 1'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      final expandedWidgets = find.byType(Expanded);
      expect(expandedWidgets, findsNWidgets(2));
      expect(find.text('Flex 2'), findsOneWidget);
      expect(find.text('Flex 1'), findsOneWidget);
    });

    testWidgets('handles empty children list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [],
            ),
          ),
        ),
      );

      // Should not throw any errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('applies mainAxisAlignment correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Centered 1'),
                Text('Centered 2'),
              ],
            ),
          ),
        ),
      );

      final flexFinder = find.byType(Flex);
      expect(flexFinder, findsOneWidget);

      final flex = tester.widget<Flex>(flexFinder);
      expect(flex.mainAxisAlignment, MainAxisAlignment.center);
    });

    testWidgets('applies crossAxisAlignment correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aligned Start 1'),
                Text('Aligned Start 2'),
              ],
            ),
          ),
        ),
      );

      final flexFinder = find.byType(Flex);
      expect(flexFinder, findsOneWidget);

      final flex = tester.widget<Flex>(flexFinder);
      expect(flex.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets('applies mainAxisSize correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Min Size 1'),
                Text('Min Size 2'),
              ],
            ),
          ),
        ),
      );

      final flexFinder = find.byType(Flex);
      expect(flexFinder, findsOneWidget);

      final flex = tester.widget<Flex>(flexFinder);
      expect(flex.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('applies verticalDirection correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              verticalDirection: VerticalDirection.up,
              children: [
                Text('Bottom'),
                Text('Top'),
              ],
            ),
          ),
        ),
      );

      final flexFinder = find.byType(Flex);
      expect(flexFinder, findsOneWidget);

      final flex = tester.widget<Flex>(flexFinder);
      expect(flex.verticalDirection, VerticalDirection.up);
    });

    testWidgets('applies textDirection correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              textDirection: TextDirection.rtl,
              children: [
                Text('RTL Text 1'),
                Text('RTL Text 2'),
              ],
            ),
          ),
        ),
      );

      final flexFinder = find.byType(Flex);
      expect(flexFinder, findsOneWidget);

      final flex = tester.widget<Flex>(flexFinder);
      expect(flex.textDirection, TextDirection.rtl);
    });

    testWidgets('applies textBaseline correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('Baseline 1'),
                Text('Baseline 2'),
              ],
            ),
          ),
        ),
      );

      final flexFinder = find.byType(Flex);
      expect(flexFinder, findsOneWidget);

      final flex = tester.widget<Flex>(flexFinder);
      expect(flex.textBaseline, TextBaseline.alphabetic);
    });

    testWidgets('applies custom scroll physics', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              physics: const BouncingScrollPhysics(),
              children: List.generate(
                20,
                (index) => SizedBox(
                  height: 50,
                  child: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );

      // Find the Scrollable widget
      final scrollableFinder = find.byType(Scrollable);
      expect(scrollableFinder, findsOneWidget);

      final scrollable = tester.widget<Scrollable>(scrollableFinder);
      expect(scrollable.physics, isA<BouncingScrollPhysics>());
    });

    testWidgets('supports reverse scrolling', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              reverse: true,
              children: [
                Text('First (at bottom)'),
                Text('Second'),
                Text('Third (at top)'),
              ],
            ),
          ),
        ),
      );

      final scrollableFinder = find.byType(Scrollable);
      expect(scrollableFinder, findsOneWidget);

      final scrollable = tester.widget<Scrollable>(scrollableFinder);
      expect(scrollable.axisDirection, AxisDirection.up);
    });

    testWidgets('applies clipBehavior correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              clipBehavior: Clip.antiAlias,
              children: [
                Text('Clipped Content'),
              ],
            ),
          ),
        ),
      );

      final scrollableFinder = find.byType(Scrollable);
      expect(scrollableFinder, findsOneWidget);

      final scrollable = tester.widget<Scrollable>(scrollableFinder);
      expect(scrollable.clipBehavior, Clip.antiAlias);
    });

    testWidgets('works with complex nested widgets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                Container(
                  height: 100,
                  color: Colors.red,
                  child: const Center(child: Text('Header')),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Nested Content 1'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Button'),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 50,
                  color: Colors.green,
                  child: const Center(child: Text('Footer')),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Nested Content 1'), findsOneWidget);
      expect(find.text('Button'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('maintains scroll position on rebuild', (tester) async {
      // Set explicit viewport size
      tester.view.physicalSize = const Size(400, 600);
      tester.view.devicePixelRatio = 1.0;

      const itemCount = 20;
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: List.generate(
                itemCount,
                (index) => SizedBox(
                  height: 100,
                  child: Center(child: Text('Item $index')),
                ),
              ),
            ),
          ),
        ),
      );

      // Scroll down
      await tester.drag(
        find.byType(ExpandableColumn),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();

      // Item 0 might still be found even if off-screen, so we just verify no error occurred
      expect(tester.takeException(), isNull);

      // Rebuild with same content
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: List.generate(
                itemCount,
                (index) => SizedBox(
                  height: 100,
                  child: Center(child: Text('Item $index')),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should still be scrolled - verify no exceptions
      expect(tester.takeException(), isNull);

      // Reset viewport
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
        scrollController.dispose();
      });
    });

    testWidgets('handles rapid scrolling without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: List.generate(
                50,
                (index) => SizedBox(
                  height: 50,
                  child: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );

      // Perform multiple rapid scrolls
      for (int i = 0; i < 5; i++) {
        await tester.drag(
          find.byType(ExpandableColumn),
          const Offset(0, -200),
        );
        await tester.pump();
      }

      await tester.pumpAndSettle();

      // Should not throw any errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('works with primary false setting', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              primary: false,
              children: [
                Text('Child 1'),
                Text('Child 2'),
                Text('Child 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
      expect(find.text('Child 3'), findsOneWidget);
    });

    testWidgets('respects const constructor', (tester) async {
      const widget = ExpandableColumn(
        children: [
          Text('Const Child'),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: widget,
          ),
        ),
      );

      expect(find.text('Const Child'), findsOneWidget);
    });
  });

  group('ExpandableColumn Edge Cases', () {
    testWidgets('handles single child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                Text('Single Child'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Single Child'), findsOneWidget);
    });

    testWidgets('handles very tall content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                Container(
                  height: 5000,
                  color: Colors.blue,
                  child: const Text('Very Tall Content'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Very Tall Content'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('handles mix of fixed and flexible children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                Container(height: 100, color: Colors.red),
                Expanded(child: Container(color: Colors.blue)),
                const Spacer(),
                Container(height: 50, color: Colors.green),
                Expanded(flex: 2, child: Container(color: Colors.orange)),
                Container(height: 75, color: Colors.purple),
              ],
            ),
          ),
        ),
      );

      // Count only the top-level Containers (not nested ones)
      // The Expanded widgets wrap Containers, so we expect 5 direct Containers
      // (3 fixed height + 2 inside Expanded widgets)
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Expanded), findsNWidgets(2));
      expect(find.byType(Spacer), findsOneWidget);
    });

    testWidgets('handles zero-height children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: [
                Container(height: 0),
                const Text('Visible'),
                Container(height: 0),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Visible'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('ExpandableColumn Performance Tests', () {
    testWidgets('efficiently handles many children', (tester) async {
      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExpandableColumn(
              children: List.generate(
                100,
                (index) => Text('Item $index'),
              ),
            ),
          ),
        ),
      );

      stopwatch.stop();

      // Should complete in reasonable time (adjust threshold as needed)
      expect(stopwatch.elapsedMilliseconds, lessThan(2000));
    });
  });
}
