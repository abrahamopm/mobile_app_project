import 'package:flutter/material.dart';
import '../models/client_model.dart';
import 'client_detail_screen.dart';

class ClientListScreen extends StatelessWidget {
  const ClientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = [
      Client(id: 'c1', name: 'John Doe', phone: '123456789'),
      Client(id: 'c2', name: 'Jane Smith', phone: '987654321'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return ListTile(
            title: Text(client.name),
            subtitle: Text(client.phone),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClientDetailScreen(client: client),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
