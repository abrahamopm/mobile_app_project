import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          SwitchListTile(value: true, onChanged: null, title: Text('Notifications')),
          ListTile(title: Text('Dark Mode'), trailing: Icon(Icons.brightness_4)),
          ListTile(title: Text('Language'), trailing: Text('English')),
        ],
      ),
    );
  }
}
