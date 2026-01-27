import 'package:flutter/material.dart';
import 'package:flutter_expandable_column/flutter_expandable_column.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpandableColumn Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ExampleListScreen(),
    );
  }
}

class ExampleListScreen extends StatelessWidget {
  const ExampleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ExpandableColumn Examples')),
      body: ListView(
        children: [
          _buildExampleTile(
            context,
            'Basic Example',
            'Simple expandable column with header and footer',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BasicExample()),
            ),
          ),
          _buildExampleTile(
            context,
            'Login Form',
            'Centered login form with spacers',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginExample()),
            ),
          ),
          _buildExampleTile(
            context,
            'Dashboard Layout',
            'Multiple expanded widgets with different flex values',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DashboardExample()),
            ),
          ),
          _buildExampleTile(
            context,
            'Settings Screen',
            'Settings with spacer pushing content to bottom',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsExample()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleTile(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

// Basic Example
class BasicExample extends StatelessWidget {
  const BasicExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Example')),
      body: ExpandableColumn(
        children: [
          Container(
            height: 100,
            color: Colors.red.shade300,
            child: const Center(
              child: Text(
                'Fixed Height Header',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue.shade300,
              child: const Center(
                child: Text(
                  'This expands to fill available space',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.green.shade300,
            child: const Center(
              child: Text(
                'Fixed Height Footer',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Login Example
class LoginExample extends StatelessWidget {
  const LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Form')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ExpandableColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
            const SizedBox(height: 40),
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to continue',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.lock_outlined),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 16)),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

// Dashboard Example
class DashboardExample extends StatelessWidget {
  const DashboardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Layout')),
      body: ExpandableColumn(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.purple.shade50,
            child: const Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Main Content Area\n(Takes 2/3 of space)',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Secondary Content\n(Takes 1/3 of space)',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Footer Information',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// Settings Example
class SettingsExample extends StatefulWidget {
  const SettingsExample({super.key});

  @override
  State<SettingsExample> createState() => _SettingsExampleState();
}

class _SettingsExampleState extends State<SettingsExample> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ExpandableColumn(
        children: [
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            subtitle: Text('Manage your account settings'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Enable push notifications'),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            trailing: Switch(
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() => _darkModeEnabled = value);
              },
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
            subtitle: Text('Privacy and security settings'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  '© 2024 Your Company',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
