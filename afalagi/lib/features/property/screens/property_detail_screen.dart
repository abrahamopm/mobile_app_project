import 'package:flutter/material.dart';
import '../models/property_model.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.pushNamed(
              context, 
              '/edit-property',
              arguments: property,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${property.price}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(property.description),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Viewing with IDs
                Navigator.pushNamed(
                  context, 
                  '/log-viewing',
                  arguments: {
                    'propertyId': property.id,
                    'clientId': 'dummy_client_id', // Would come from a selector in real app
                  },
                );
              },
              child: const Text('Log Viewing'),
            ),
          ],
        ),
      ),
    );
  }
}
