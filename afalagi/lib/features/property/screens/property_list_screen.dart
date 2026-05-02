import 'package:flutter/material.dart';
import '../models/property_model.dart';
import 'property_detail_screen.dart';

class PropertyListScreen extends StatelessWidget {
  const PropertyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final properties = [
      Property(id: '1', title: 'Luxury Villa', description: 'A beautiful villa', price: 1000000),
      Property(id: '2', title: 'Modern Apartment', description: 'City center apartment', price: 500000),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Properties')),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return ListTile(
            title: Text(property.title),
            subtitle: Text('\$${property.price}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PropertyDetailScreen(property: property),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-property'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
