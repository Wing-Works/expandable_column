import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// A custom scroll view that ensures its single child fills the remaining
/// viewport space without allowing scrolling when content is smaller than
/// the viewport.
///
/// This is useful for layouts where you want content to be centered or
/// fill available space, but still allow scrolling if content exceeds
/// the viewport height.`
@internal
class ScrollableView extends ScrollView {
  /// Creates a scroll view with a single child that fills remaining space.
  ///
  /// The [child] parameter must not be null.
  @internal
  const ScrollableView({
    required this.child,
    super.scrollDirection,
    super.reverse = false,
    super.controller,
    super.primary,
    super.physics = const ClampingScrollPhysics(),
    super.clipBehavior = Clip.hardEdge,
    super.restorationId,
    super.key,
  });

  /// The widget to display as the scroll view's child.
  final Widget child;

  @override
  List<Widget> buildSlivers(_) => [_FillRemainingNoScroll(child: child)];
}

/// A sliver that fills the remaining space in the viewport with its child.
///
/// This is a private implementation detail of [ScrollableView].
class _FillRemainingNoScroll extends SingleChildRenderObjectWidget {
  const _FillRemainingNoScroll({super.child});

  @override
  RenderSliverFillRemaining createRenderObject(BuildContext context) {
    return RenderSliverFillRemaining();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('hasScrollBody', false));
  }
}
