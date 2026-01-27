# Expandable Column

A scrollable column widget that supports `Expanded` and `Spacer` widgets. Combines the flexibility of `Column` with the scrolling capability of `ScrollView` for dynamic, space-aware layouts.

## Features

✨ **Use `Expanded` and `Spacer`** - Unlike `ListView`, fully supports flex widgets  
📱 **Automatic Scrolling** - Scrolls when content overflows the viewport  
🎯 **Space Distribution** - Children can expand to fill available space  
⚡ **Performance Optimized** - Built on Flutter's efficient sliver system  
🎨 **Highly Customizable** - All standard `Column` and `ScrollView` properties supported

## Why Use This Package?

### The Problem

In Flutter, you often face a dilemma:

- **`Column`** supports `Expanded` and `Spacer`, but doesn't scroll when content overflows
- **`ListView`** scrolls perfectly, but doesn't support `Expanded` or `Spacer` widgets
- **`SingleChildScrollView`** with `Column` scrolls, but `Expanded` widgets throw errors

### The Solution

`ExpandableColumn` gives you the best of both worlds:
```dart
ExpandableColumn(
  children: [
    Text('Header'),
    Expanded(
      child: Container(
        color: Colors.blue,
        child: Center(child: Text('This fills available space')),
      ),
    ),
    Spacer(),
    Text('Footer'),
  ],
)
```

## Installation

Add this to your `pubspec.yaml`:
```yaml
dependencies:
  expandable_column: ^0.0.1
```

Then run:
```bash
flutter pub get
```

## Usage

### Basic Example
```dart
import 'package:flutter/material.dart';
import 'package:flutter_expandable_column/flutter_expandable_column.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expandable Column Example')),
      body: ExpandableColumn(
        children: [
          Container(
            height: 100,
            color: Colors.red,
            child: Center(child: Text('Fixed Height Header')),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text('This expands to fill available space'),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.green,
            child: Center(child: Text('Fixed Height Footer')),
          ),
        ],
      ),
    );
  }
}
```

### Form with Dynamic Content
```dart
ExpandableColumn(
  padding: EdgeInsets.all(16),
  children: [
    Text(
      'User Registration',
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    SizedBox(height: 20),
    TextField(decoration: InputDecoration(labelText: 'Name')),
    TextField(decoration: InputDecoration(labelText: 'Email')),
    TextField(decoration: InputDecoration(labelText: 'Password')),
    Spacer(), // Pushes button to bottom
    ElevatedButton(
      onPressed: () {},
      child: Text('Submit'),
    ),
  ],
)
```

### Multiple Expanded Widgets
```dart
ExpandableColumn(
  children: [
    Text('Dashboard'),
    Expanded(
      flex: 2,
      child: Container(
        color: Colors.amber,
        child: Center(child: Text('Takes 2/3 of space')),
      ),
    ),
    Expanded(
      flex: 1,
      child: Container(
        color: Colors.purple,
        child: Center(child: Text('Takes 1/3 of space')),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(16),
      child: Text('Footer Text'),
    ),
  ],
)
```

### With Custom Scroll Physics
```dart
ExpandableColumn(
  physics: BouncingScrollPhysics(), // iOS-style bouncing
  children: [
    // Your widgets here
  ],
)
```

### Centered Content
```dart
ExpandableColumn(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Icon(Icons.check_circle, size: 100, color: Colors.green),
    SizedBox(height: 20),
    Text('Success!', style: TextStyle(fontSize: 24)),
    SizedBox(height: 10),
    Text('Your action was completed successfully.'),
  ],
)
```

## API Reference

### ExpandableColumn Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `children` | `List<Widget>` | required | The widgets to display vertically |
| `mainAxisAlignment` | `MainAxisAlignment` | `start` | How children are aligned vertically |
| `mainAxisSize` | `MainAxisSize` | `max` | How much vertical space to occupy |
| `crossAxisAlignment` | `CrossAxisAlignment` | `center` | How children are aligned horizontally |
| `textDirection` | `TextDirection?` | `null` | Order for horizontal layout |
| `verticalDirection` | `VerticalDirection` | `down` | Order for vertical layout |
| `textBaseline` | `TextBaseline?` | `null` | Baseline for alignment |
| `physics` | `ScrollPhysics?` | `null` | Scroll physics behavior |
| `primary` | `bool?` | `null` | Whether this is the primary scroll view |
| `reverse` | `bool` | `false` | Whether to reverse scroll direction |
| `clipBehavior` | `Clip` | `hardEdge` | How to clip content |

## Common Use Cases

### 1. Login Screen with Logo
```dart
ExpandableColumn(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Spacer(flex: 2),
    Image.asset('assets/logo.png', height: 120),
    SizedBox(height: 40),
    TextField(decoration: InputDecoration(labelText: 'Username')),
    SizedBox(height: 16),
    TextField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
    ),
    SizedBox(height: 24),
    ElevatedButton(
      onPressed: () {},
      child: Text('Login'),
    ),
    Spacer(flex: 3),
  ],
)
```

### 2. Chat-like Interface
```dart
ExpandableColumn(
  children: [
    Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) => MessageBubble(messages[index]),
      ),
    ),
    Divider(height: 1),
    MessageInput(),
  ],
)
```

### 3. Settings Page
```dart
ExpandableColumn(
  children: [
    ListTile(
      title: Text('Account'),
      leading: Icon(Icons.person),
      trailing: Icon(Icons.chevron_right),
    ),
    ListTile(
      title: Text('Notifications'),
      leading: Icon(Icons.notifications),
      trailing: Switch(value: true, onChanged: (_) {}),
    ),
    ListTile(
      title: Text('Privacy'),
      leading: Icon(Icons.lock),
      trailing: Icon(Icons.chevron_right),
    ),
    Spacer(),
    Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Version 1.0.0',
        style: TextStyle(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    ),
  ],
)
```

## Comparison with Alternatives

| Feature | ExpandableColumn | Column + SingleChildScrollView | ListView |
|---------|------------------|-------------------------------|----------|
| Supports `Expanded` | ✅ Yes | ❌ No (throws error) | ❌ No |
| Supports `Spacer` | ✅ Yes | ❌ No (throws error) | ❌ No |
| Scrollable | ✅ Yes | ✅ Yes | ✅ Yes |
| Fills available space | ✅ Yes | ⚠️ Limited | ❌ No |
| Performance | ✅ Optimized | ✅ Good | ✅ Optimized |

## Migration Guide

### From Column + SingleChildScrollView

**Before:**
```dart
SingleChildScrollView(
  child: Column(
    children: [
      Widget1(),
      // Can't use Expanded here!
      Widget2(),
    ],
  ),
)
```

**After:**
```dart
ExpandableColumn(
  children: [
    Widget1(),
    Expanded(child: Widget2()), // Now works!
  ],
)
```

### From Column

**Before:**
```dart
Column(
  children: [
    Widget1(),
    Expanded(child: Widget2()),
  ],
)
```

**After:**
```dart
ExpandableColumn(
  children: [
    Widget1(),
    Expanded(child: Widget2()), // Now scrollable too!
  ],
)
```

## Performance Tips

1. **Use `const` constructors** when possible for better performance
2. **Avoid deeply nested `ExpandableColumn` widgets** - use one at the root level
3. **For long lists inside `Expanded`**, use `ListView.builder` instead of `Column`
4. **Set `primary: false`** if not the primary scroll view in your screen

## Troubleshooting

### Content not scrolling?

Make sure your total content height exceeds the viewport. If content fits, there's nothing to scroll.

### `Expanded` throwing errors?

Ensure you're using `ExpandableColumn` directly, not wrapping it in additional widgets that constrain height.

### Multiple scroll views conflict?

Set `primary: false` on nested scroll views:
```dart
ExpandableColumn(
  primary: false, // Important!
  children: [
    Expanded(
      child: ListView(...),
    ),
  ],
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support
- 🐛 Issues: [GitHub Issues](https://github.com/wing-works/expandable_column/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/wing-works/flutter_expandable_column/discussions)

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

## Acknowledgments

- Built with Flutter's powerful sliver system
- Inspired by the common need to combine `Column` flexibility with `ScrollView` scrolling

---

**Made with ❤️ for the Flutter community**