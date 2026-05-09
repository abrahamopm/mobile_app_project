import 'package:flutter/material.dart';
import 'package:afalagi/core/theme/theme.dart';
import 'package:afalagi/core/widgets/scaffold.dart';
import 'package:afalagi/core/widgets/button.dart';
import 'package:afalagi/core/widgets/image.dart';

void main() => runApp(const ClientApp());

class ClientApp extends StatelessWidget {
  const ClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client List',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ClientListScreen(),
    );
  }
}

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  String _searchQuery = '';
  String _selectedPriority = 'MODERATE';

  final List<Map<String, dynamic>> _clients = [
    {
      'id': 'c1',
      'name': 'Dawit Mengistu',
      'phone': '+251 91 123 4567',
      'priority': 'VIP',
      'interest': 5,
      'area': 'Bole, Penthouse',
      'budget': '45M – 60M ETB'
    },
    {
      'id': 'c2',
      'name': 'Sara Haile',
      'phone': '+251 92 887 6654',
      'priority': 'MODERATE',
      'interest': 3
    },
    {
      'id': 'c3',
      'name': 'Abebe Yosef',
      'phone': '+251 94 332 1198',
      'priority': 'HIGH',
      'interest': 4
    },
    {
      'id': 'c4',
      'name': 'Martha Tadesse',
      'phone': '+251 91 554 3321',
      'priority': 'MODERATE',
      'interest': 2
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredClients {
    if (_searchQuery.isEmpty) return _clients;
    return _clients.where((c) => 
      c['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      (c['area']?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
    ).toList();
  }

  void _showClientDialog({Map<String, dynamic>? client, int? index}) {
    if (client != null) {
      _nameController.text = client['name'];
      _phoneController.text = client['phone'];
      _selectedPriority = client['priority'];
    } else {
      _nameController.clear();
      _phoneController.clear();
      _selectedPriority = 'MODERATE';
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(client == null ? 'New Acquisition' : 'Edit Client'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name')),
              TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone Number')),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedPriority,
                isExpanded: true,
                items: ['VIP', 'HIGH', 'MODERATE', 'LOW'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => setDialogState(() => _selectedPriority = val!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                setState(() {
                  final newClient = {
                    'id': client?['id'] ?? DateTime.now().toString(),
                    'name': _nameController.text,
                    'phone': _phoneController.text,
                    'priority': _selectedPriority,
                    'interest': client?['interest'] ?? 3,
                    'area': client?['area'] ?? 'N/A',
                    'budget': client?['budget'] ?? 'N/A',
                  };
                  if (index != null) {
                    _clients[index] = newClient;
                  } else {
                    _clients.insert(0, newClient);
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteClient(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Client'),
        content: const Text('Remove this client from your portfolio?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() => _clients.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 15),
                  CustomButton(
                    onPressed: () => _showClientDialog(),
                    text: 'New Acquisition',
                    icon: Icons.add,
                  ),
                  const SizedBox(height: 25),
                  ..._filteredClients.asMap().entries.map((entry) {
                    final client = entry.value;
                    final index = _clients.indexOf(client);
                    return client['priority'] == 'VIP' 
                      ? Column(children: [_buildFeaturedCard(context, client, index), const SizedBox(height: 16)])
                      : _buildClientCard(context, client, index);
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomScaffold.bottomNavigationBar((index) {}, 2),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10)
                    ]),
                child: Icon(Icons.home_work_outlined,
                    color: AppTheme.primaryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Text('Afalagi',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor)),
            ],
          ),
          const Icon(Icons.notifications_outlined, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFEDF1F5), borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: const InputDecoration(
          hintText: 'Search by name, property type...',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context, Map<String, dynamic> client, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 20,
                offset: const Offset(0, 10))
          ]),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
              top: -20,
              right: -20,
              child: CircleAvatar(
                  radius: 60, backgroundColor: const Color(0xFFF1F4F9))),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomImages.resilientImage(
                          'https://api.dicebear.com/7.x/avataaars/png?seed=${client['name']}',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildPriorityBadge(client['priority']),
                              _buildClientMenu(client, index),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(client['name'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor)),
                          Text(client['phone'],
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(child: _buildInfoBox('TARGET AREA', client['area'])),
                  const SizedBox(width: 12),
                  Expanded(child: _buildInfoBox('BUDGET SCALE', client['budget']))
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientCard(
      BuildContext context, Map<String, dynamic> client, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                  child: CustomImages.resilientImage(
                      'https://api.dicebear.com/7.x/avataaars/png?seed=${client['name']}',
                      width: 48,
                      height: 48)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(client['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(client['phone'],
                          style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ]),
              ),
              _buildClientMenu(client, index),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    children: List.generate(
                        5,
                        (i) => Icon(
                            i < client['interest'] ? Icons.star : Icons.star_border,
                            color: const Color(0xFF964B00),
                            size: 16))),
                Text(client['priority'],
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: const Color(0xFFD1FAE5),
          borderRadius: BorderRadius.circular(8)),
      child: Text(priority,
          style: const TextStyle(
              color: Color(0xFF065F46),
              fontSize: 10,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInfoBox(String title, String? value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFFF1F4F9),
          borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
                fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value ?? 'N/A',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor)),
      ]),
    );
  }

  Widget _buildClientMenu(Map<String, dynamic> client, int index) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
      onSelected: (val) {
        if (val == 'edit') _showClientDialog(client: client, index: index);
        if (val == 'delete') _deleteClient(index);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit', 
          child: Row(children: [Icon(Icons.edit, size: 18), 
          SizedBox(width: 8), 
          Text('Edit')
          ])),
        const PopupMenuItem(
          value: 'delete', 
          child: Row(children: [Icon(Icons.delete, size: 18, color: Colors.red), 
          SizedBox(width: 8), 
          Text('Delete', style: TextStyle(color: Colors.red))])),
      ],
    );
  }
}