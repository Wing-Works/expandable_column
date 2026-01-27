# Contributing to Expandable Column

Thank you for your interest in contributing to **Expandable Column** 🎉

This document defines the **non-negotiable design rules and standards** for the project.  
Expandable Column is intentionally focused, performant, and predictable.  
All contributions must follow the rules below to keep the API clean and stable.

---

## 1. Public vs Internal APIs

### Public API

Anything exported from `lib/flutter_expandable_column.dart` is considered **public and stable**.

This includes:
- `ExpandableColumn` - The main widget

**Rule:**
> Once an API is public, it can only be removed or renamed in a **major version**.

---

### Internal API

Anything in `lib/src/` not exported from the main library is considered **internal** and must be marked with `@internal`.

Internal implementations include:
- `_ExpandableScrollView`
- `_SliverFillViewport`
- `_RenderSliverFillViewport`
- `_FlexViewport`
- `_RenderFlexViewport`
- `_LayoutInfo`

**Rule:**
> Internal APIs may change freely and should not be relied upon by users.  
> All internal classes must use the `_` prefix or be annotated with `@internal`.

---

## 2. Widget API Rules (Strict)

### Parameter Naming

The following parameter names are **locked** and must not be changed:

| Concept | Name | Type |
|---------|------|------|
| Widget list | `children` | `List<Widget>` |
| Vertical alignment | `mainAxisAlignment` | `MainAxisAlignment` |
| Horizontal alignment | `crossAxisAlignment` | `CrossAxisAlignment` |
| Size behavior | `mainAxisSize` | `MainAxisSize` |
| Text direction | `textDirection` | `TextDirection?` |
| Vertical direction | `verticalDirection` | `VerticalDirection` |
| Baseline alignment | `textBaseline` | `TextBaseline?` |
| Scroll physics | `physics` | `ScrollPhysics?` |
| Primary scroll | `primary` | `bool?` |
| Reverse scrolling | `reverse` | `bool` |
| Clipping | `clipBehavior` | `Clip` |
| Scroll control | `controller` | `ScrollController?` |
| Inner padding | `padding` | `EdgeInsetsGeometry?` |
| Cache optimization | `cacheExtent` | `double?` |

**Rules:**
- ❌ No aliases (e.g., no `alignment` for `mainAxisAlignment`)
- ❌ No synonyms (e.g., no `direction` for `verticalDirection`)
- ❌ No creative naming (stick to Flutter conventions)
- ✅ Follow Flutter's `Column` and `ScrollView` naming patterns exactly

Consistency with Flutter's core widgets is more important than creativity.

---

## 3. Implementation Architecture Rules

### Render Object Layer (Mandatory)

Core functionality **must** be implemented at the RenderObject level.

**Allowed:**
- Custom `RenderBox` implementations
- Custom `RenderSliver` implementations
- Multi-child layout algorithms
- Direct constraint and geometry calculations

**Forbidden:**
- Implementing core logic in `StatefulWidget`
- Using simple widget composition for core features
- Wrapper widgets around existing Flutter widgets

**Reason:**  
The package value comes from sophisticated low-level implementation that cannot be easily copy-pasted.

---

### Widget Layer (Minimal)

The `ExpandableColumn` widget must be a **thin wrapper** that:
1. Accepts parameters
2. Builds the render object tree
3. Does NO layout logic

**Rule:**
> All layout logic must live in `_RenderFlexViewport`, not in widget code.

---

### Sliver Integration (Required)

Scrolling must be implemented using **custom sliver protocol**.

**Mandatory components:**
- `_RenderSliverFillViewport` for viewport integration
- Proper `SliverGeometry` calculations
- Correct `scrollExtent` and `paintExtent` handling

**Forbidden:**
- Using `SliverFillRemaining` directly without customization
- Delegating to `CustomScrollView` without custom slivers

---

## 4. Performance Rules (Non-Negotiable)

### Layout Efficiency

**Required:**
- Multi-phase layout algorithm (measure, flex distribute, position)
- Single-pass layout where possible
- Proper `markNeedsLayout()` usage only when properties change

**Forbidden:**
- Rebuilding widgets on scroll
- Re-measuring children unnecessarily
- Nested layout passes for the same constraints

---

### Memory Efficiency

**Required:**
- Reuse Flutter's `FlexParentData`
- Use object pooling for layout info when possible
- Minimize temporary allocations in layout

**Forbidden:**
- Creating new objects in `performLayout()` unnecessarily
- Storing redundant state
- Memory leaks from unclosed controllers

---

## 5. Testing Requirements (Hard Requirements)

### Test Coverage Thresholds

- **Widget API:** 100% coverage
- **Layout logic:** 95% coverage minimum
- **Edge cases:** Must all be covered

### Required Test Categories

Every PR must include tests for:

1. **Basic functionality** - Does it work?
2. **Flex behavior** - Expanded and Spacer widgets
3. **Alignment** - All MainAxisAlignment values
4. **Scrolling** - Content overflow and physics
5. **Edge cases** - Empty children, single child, etc.
6. **Performance** - No degradation with many children
7. **Updates** - Property changes trigger correct updates

**Rule:**
> If you can't write a test for it, you can't merge it.

---

### Test Structure (Mandatory)
````dart
group('Feature Name', () {
  testWidgets('should do X when Y', (tester) async {
    // Arrange
    await tester.pumpWidget(/* setup */);
    
    // Act
    await tester.pumpAndSettle();
    
    // Assert
    expect(/* verification */);
  });
});
````

**Forbidden:**
- Tests without descriptive names
- Tests that sometimes pass
- Tests that depend on timing
- Tests without proper cleanup

---

## 6. Documentation Rules (Hard Requirement)

### Public API Documentation

Every public parameter must include:

1. **Clear description** - What does it do?
2. **Default value** - What happens if omitted?
3. **Behavior** - How does it interact with other parameters?
4. **Example** - At least one code sample

**Example (Required format):**
````dart
/// How the children should be placed along the main axis (vertically).
///
/// For example, [MainAxisAlignment.start] places the children at the top
/// of the column, while [MainAxisAlignment.center] centers them vertically.
///
/// This interacts with [mainAxisSize] - when [MainAxisSize.min] is used,
/// alignment has no effect as there is no free space to distribute.
///
/// Example:
/// ```dart
/// ExpandableColumn(
///   mainAxisAlignment: MainAxisAlignment.spaceBetween,
///   children: [
///     Text('Top'),
///     Text('Bottom'),
///   ],
/// )
/// ```
///
/// Defaults to [MainAxisAlignment.start].
final MainAxisAlignment mainAxisAlignment;
````

**Rule:**
> If documentation is missing or incomplete, the PR will be rejected immediately.

---

### Internal Documentation

Render object code must include:

1. **Algorithm explanation** - How does the layout work?
2. **Phase documentation** - What happens in each phase?
3. **Complexity notes** - O(n) behavior documented
4. **Edge case handling** - How are special cases handled?

**Example:**
````dart
/// Custom render object implementing flex layout algorithm.
///
/// Layout happens in three phases:
/// 1. Measure non-flex children and collect flex information
/// 2. Distribute remaining space to flex children proportionally
/// 3. Position all children based on alignment settings
///
/// Time complexity: O(n) where n is the number of children
/// Space complexity: O(n) for storing layout information
class _RenderFlexViewport extends RenderBox { }
````

---

## 7. Breaking Changes Policy

| Version | Policy |
|---------|--------|
| `0.x.y` | Minor breaking changes allowed with migration guide |
| `1.x.y` | No breaking changes whatsoever |
| `2.0.0+` | Breaking changes allowed with deprecation period |

**Migration Guide Requirement:**

Every breaking change must include:
````markdown
### Breaking Change: [Description]

**Before:**
```dart
// Old code
```

**After:**
```dart
// New code
```

**Migration:**
Step-by-step instructions
````

---

## 8. Code Style Rules (Automated)

### Formatting (Enforced)
````bash
# Must pass before PR
dart format --set-exit-if-changed .
````

**Rules:**
- 80 character line limit (hard limit)
- 2 space indentation (no tabs)
- Trailing commas for better diffs

---

### Linting (Enforced)
````bash
# Must pass before PR
flutter analyze
````

**Zero warnings policy:**
> Any `flutter analyze` warning must be fixed or explicitly suppressed with documented reason.

---

### Naming Conventions (Enforced)
````dart
// Classes, enums, typedefs
class ExpandableColumn { }          // ✅ Correct
class expandableColumn { }          // ❌ Wrong

// Private classes
class _FlexViewport { }             // ✅ Correct
class _flexViewport { }             // ❌ Wrong

// Variables, parameters
final mainAxisAlignment = ...;     // ✅ Correct
final MainAxisAlignment = ...;     // ❌ Wrong

// Constants
const defaultClipBehavior = ...;   // ✅ Correct
const DEFAULT_CLIP_BEHAVIOR = ...;  // ❌ Wrong (no SCREAMING_SNAKE_CASE)
````

---

## 9. Pull Request Process

### Before Submitting

**Mandatory checklist:**
````bash
# 1. Format code
dart format .

# 2. Analyze code
flutter analyze

# 3. Run tests
flutter test

# 4. Check coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
# Open coverage/html/index.html and verify >90%

# 5. Update CHANGELOG.md
# Add your changes under [Unreleased]

# 6. Update documentation
# If you changed public API, update README.md
````

**Rule:**
> If any of these steps fail, **do not** submit the PR.

---

### Commit Messages (Strict Format)
````
type(scope): subject

[optional body]

[optional footer]
````

**Types (only these):**
- `feat` - New feature
- `fix` - Bug fix
- `perf` - Performance improvement
- `refactor` - Code refactoring (no behavior change)
- `test` - Adding or updating tests
- `docs` - Documentation only
- `chore` - Maintenance (deps, tooling, etc.)

**Scopes (only these):**
- `column` - ExpandableColumn widget
- `render` - Render object layer
- `sliver` - Sliver implementation
- `test` - Test infrastructure
- `docs` - Documentation
- `example` - Example app

**Examples:**
````
feat(column): add padding parameter

Adds optional padding parameter that applies inside
the scrollable area. Padding scrolls with content.

Closes #42
````
````
perf(render): optimize layout algorithm

Reduces layout passes from 3 to 2 by combining
measurement and flex distribution phases.

Improves layout time by ~15% for 100+ children.
````

**Forbidden:**
- `update stuff`
- `fix bug`
- `changes`
- `wip`

---

### PR Description Template (Mandatory)
````markdown
## Description
<!-- Clear description of what this PR does -->

## Motivation
<!-- Why is this change needed? -->

## Type of Change
- [ ] Bug fix (non-breaking)
- [ ] New feature (non-breaking)
- [ ] Breaking change
- [ ] Documentation update
- [ ] Performance improvement

## Implementation Details
<!-- How does this work? Any tricky parts? -->

## Testing
<!-- How did you test this? -->
- [ ] Added unit tests
- [ ] Added widget tests
- [ ] Tested in example app
- [ ] Tested on iOS
- [ ] Tested on Android
- [ ] Tested on Web (if applicable)

## Performance Impact
<!-- Does this affect performance? Provide benchmarks if yes -->

## Checklist
- [ ] Code follows style guidelines (`dart format` passes)
- [ ] No analysis warnings (`flutter analyze` passes)
- [ ] All tests pass (`flutter test`)
- [ ] Test coverage >90%
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Breaking changes documented with migration guide
- [ ] Example app demonstrates the change (if applicable)

## Screenshots/Videos
<!-- If UI-related, show before/after -->

## Related Issues
Closes #
````

**Rule:**
> PRs without proper description will be closed immediately.

---

## 10. What We Don't Accept

### ❌ Rejected Contributions

We will **immediately close** PRs that:

1. **Add unnecessary complexity**
    - Helper functions that wrap existing APIs
    - Convenience methods that duplicate functionality
    - "Maybe useful someday" features

2. **Break the render object architecture**
    - Moving logic to StatefulWidget
    - Using widget composition instead of custom render objects
    - Simplifying implementation to make it "easier"

3. **Violate naming conventions**
    - Creative aliases for existing parameters
    - Non-Flutter-standard naming
    - Abbreviations or shortened names

4. **Have poor performance**
    - Unnecessary rebuilds
    - Inefficient layout algorithms
    - Memory leaks

5. **Lack tests or documentation**
    - Missing test coverage
    - Incomplete documentation
    - No examples

**Reason:**  
This package's value comes from being sophisticated and performant.  
If it becomes simple enough to copy-paste, it has failed its purpose.

---

## 11. Contribution Decision Tree

Before starting work, ask yourself:
````
Is this a bug fix?
├─ Yes → Does it have a test that fails?
│  ├─ Yes → Proceed
│  └─ No → Write the test first
└─ No → Is this a new feature?
   ├─ Yes → Does it require render object changes?
   │  ├─ Yes → Is the performance impact acceptable?
   │  │  ├─ Yes → Is the API surface minimal?
   │  │  │  ├─ Yes → Create an issue to discuss
   │  │  │  └─ No → Simplify the API
   │  │  └─ No → Optimize or reconsider
   │  └─ No → Should this be in the package?
   │     ├─ Yes → Prove it with a compelling use case
   │     └─ No → Don't submit
   └─ No → Is this a documentation/example improvement?
      ├─ Yes → Proceed
      └─ No → What type of contribution is this?
````

**Rule:**
> If you're unsure, **create an issue first** before writing code.

---

## 12. Philosophy

### Core Principles

1. **Sophistication over simplicity**  
   Users should prefer `pub get` over copy-paste because the implementation is complex.

2. **Performance over convenience**  
   Every millisecond in layout matters. Optimize aggressively.

3. **Predictability over flexibility**  
   Better to do one thing perfectly than many things poorly.

4. **Explicitness over magic**  
   No hidden behaviors. Everything should be documentable.

5. **Compatibility over innovation**  
   Match Flutter's conventions exactly. Don't invent new patterns.

---

## 13. Recognition

Contributors will be recognized in:
- CHANGELOG.md (all contributors)
- README.md (significant contributions)
- Package documentation (major features)

---

## Questions?

- 📧 Email: your.email@example.com
- 💬 GitHub Discussions: Create a discussion
- 🐛 Bug Reports: Create an issue
- ✨ Feature Requests: Create an issue with detailed justification

---

Thank you for helping keep Expandable Column focused, performant, and valuable.

**Remember:** This is not a general-purpose widget library. It solves one problem extremely well.