import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogViewingScreen extends StatelessWidget {
  final String? propertyId;
  final String? clientId;

  const LogViewingScreen({super.key, this.propertyId, this.clientId});

  @override
  Widget build(BuildContext context) {
    final String pId = propertyId ?? 'N/A';
    final String cId = clientId ?? 'N/A';

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
              onPressed: () => context.pop(),
              child: const Text('Save Log'),
            ),
          ],
        ),
      ),
    );
  }
}
