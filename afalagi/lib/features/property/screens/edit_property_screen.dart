import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/property_model.dart';

class EditPropertyScreen extends StatelessWidget {
  final Property? property;

  const EditPropertyScreen({super.key, this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Property')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Editing: ${property?.title ?? "Unknown"}'),
            const TextField(decoration: InputDecoration(labelText: 'Title')),
            const TextField(decoration: InputDecoration(labelText: 'Price')),
            const TextField(decoration: InputDecoration(labelText: 'Description')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: const Icon(Icons.save),
      ),
    );
  }
}
