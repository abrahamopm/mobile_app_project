import 'package:flutter/material.dart';
import '../models/property_model.dart';

class EditPropertyScreen extends StatelessWidget {
  final Property? property; // Can be passed via constructor or arguments

  const EditPropertyScreen({super.key, this.property});

  @override
  Widget build(BuildContext context) {
    // If null, try to get from arguments
    final Property? prop = property ?? ModalRoute.of(context)?.settings.arguments as Property?;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Property')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Editing: ${prop?.title ?? "Unknown"}'),
            const TextField(decoration: InputDecoration(labelText: 'Title')),
            const TextField(decoration: InputDecoration(labelText: 'Price')),
            const TextField(decoration: InputDecoration(labelText: 'Description')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.save),
      ),
    );
  }
}
