import 'package:flutter/material.dart';

class LogViewingScreen extends StatelessWidget {
  final String? propertyId;
  final String? clientId;

  const LogViewingScreen({super.key, this.propertyId, this.clientId});

  @override
  Widget build(BuildContext context) {
    // If null, try to get from arguments
    final Map? args = ModalRoute.of(context)?.settings.arguments as Map?;
    final String pId = propertyId ?? args?['propertyId'] ?? 'N/A';
    final String cId = clientId ?? args?['clientId'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(title: const Text('Log Viewing')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Property ID: $pId'),
            Text('Client ID: $cId'),
            const TextField(decoration: InputDecoration(labelText: 'Notes')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Save Log'),
            ),
          ],
        ),
      ),
    );
  }
}
