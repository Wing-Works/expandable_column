import 'package:expandable_column/src/scrollable_view.dart';
import 'package:flutter/widgets.dart';

/// An expandable column widget that supports scrolling while allowing
/// the use of `Expanded` and `Spacer` widgets within its children.
///
/// This widget combines the functionality of a [Column] with scrolling
/// capabilities, making it ideal for layouts that need to expand to fill
/// available space while remaining scrollable when content overflows.
///
/// Unlike a regular [Column] wrapped in a [SingleChildScrollView],
/// [ExpandableColumn] allows you to use [Expanded] and [Spacer] widgets
/// to control space distribution among children while maintaining
/// scroll functionality.
///
/// ## Example
///
/// ```dart
/// ExpandableColumn(
///   padding: EdgeInsets.all(16.0),
///   children: [
///     Text('Header'),
///     Expanded(
///       child: Container(
///         color: Colors.blue,
///         child: Center(child: Text('This fills available space')),
///       ),
///     ),
///     Spacer(),
///     Text('Footer'),
///   ],
/// )
/// ```
///
/// ## Use Cases
///
/// - Forms with varying content heights
/// - Layouts with sticky headers/footers and scrollable middle content
/// - Dynamic content that needs to expand but remain scrollable
///
/// See also:
///
/// * [Column], which provides similar layout but without scrolling
/// * [ListView], which provides scrolling but doesn't support [Expanded]
/// * [SingleChildScrollView], which provides scrolling for a single widget
class ExpandableColumn extends StatelessWidget {
  /// Creates an expandable column widget.
  ///
  /// The [children] parameter must not be null but can be empty.
  /// All other parameters are optional and have sensible defaults.
  const ExpandableColumn({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.physics,
    this.primary,
    this.reverse = false,
    this.clipBehavior = Clip.hardEdge,
    super.key,
  });

  /// The widgets to display in this column.
  ///
  /// These widgets will be arranged vertically and can include
  /// [Expanded] and [Spacer] widgets to control space distribution.
  final List<Widget> children;

  /// How the children should be placed along the main axis (vertically).
  ///
  /// For example, [MainAxisAlignment.start] places the children at the top
  /// of the column, while [MainAxisAlignment.center] centers them vertically.
  ///
  /// Defaults to [MainAxisAlignment.start].
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// When set to [MainAxisSize.max] (the default), the column will expand
  /// to fill all available vertical space. When set to [MainAxisSize.min],
  /// the column will only take up the minimum space needed by its children.
  ///
  /// Defaults to [MainAxisSize.max] to fill all available space.
  final MainAxisSize mainAxisSize;

  /// How the children should be placed along the cross axis (horizontally).
  ///
  /// For example, [CrossAxisAlignment.start] aligns children to the left,
  /// while [CrossAxisAlignment.stretch] forces children to fill the width.
  ///
  /// Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// start and end in the horizontal direction.
  ///
  /// If null, defaults to the ambient [Directionality].
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// start and end in the vertical direction.
  ///
  /// If [VerticalDirection.down], children are laid out from top to bottom.
  /// If [VerticalDirection.up], children are laid out from bottom to top.
  ///
  /// Defaults to [VerticalDirection.down].
  final VerticalDirection verticalDirection;

  /// If aligning items according to their baseline, which baseline to use.
  ///
  /// This must be set if using [CrossAxisAlignment.baseline].
  final TextBaseline? textBaseline;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after
  /// the user stops dragging. If null, uses platform-specific defaults.
  ///
  /// Common values include:
  /// * [BouncingScrollPhysics] for iOS-style bouncing
  /// * [ClampingScrollPhysics] for Android-style edge glow
  final ScrollPhysics? physics;

  /// Whether this is the primary scroll view associated with the parent
  /// [PrimaryScrollController].
  ///
  /// When true, the scroll view uses the [PrimaryScrollController] and
  /// participates in automatic scrollbar behavior on desktop platforms.
  final bool? primary;

  /// Whether the scroll view scrolls in the reverse direction.
  ///
  /// If true, scrolls from bottom to top instead of top to bottom.
  ///
  /// Defaults to false.
  final bool reverse;

  /// The content will be clipped (or not) according to this option.
  ///
  /// Defaults to [Clip.hardEdge] for better performance.
  ///
  /// See [Clip] for more details on clipping behavior.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return ScrollableView(
      physics: physics,
      primary: primary,
      reverse: reverse,
      clipBehavior: clipBehavior,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: children,
      ),
    );
  }
}
