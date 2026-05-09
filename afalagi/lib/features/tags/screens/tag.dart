import 'package:flutter/material.dart';
import 'package:afalagi/core/theme/theme.dart';
import 'package:afalagi/core/widgets/button.dart';

void main() => runApp(const TagsApp());

class TagsApp extends StatelessWidget {
  const TagsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tag Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const TagsScreen(),
    );
  }
}

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _filterController = TextEditingController();
  final TextEditingController _editTagController = TextEditingController();

  Color _selectedColor = const Color(0xFF1B385E);
  String _filterQuery = '';

  final List<Color> _availableColors = [
    const Color(0xFF1B385E),
    const Color(0xFF2E6B4F),
    const Color(0xFF6B3E0C),
    const Color(0xFF006D8E),
    const Color(0xFFA6EBC9),
  ];

  final List<Map<String, dynamic>> _tags = [
    {'name': 'Luxury',             'properties': 124, 'color': const Color(0xFF1B385E)},
    {'name': 'Villa',              'properties': 85,  'color': const Color(0xFF2E6B4F)},
    {'name': 'Bole',               'properties': 312, 'color': const Color(0xFF6B3E0C)},
    {'name': 'Under Construction', 'properties': 42,  'color': const Color(0xFF006D8E)},
  ];

  @override
  void dispose() {
    _tagController.dispose();
    _filterController.dispose();
    _editTagController.dispose();
    super.dispose();
  }

  void _createTag() {
    if (_tagController.text.trim().isEmpty) return;
    setState(() {
      _tags.insert(0, {
        'name': _tagController.text.trim(),
        'properties': 0,
        'color': _selectedColor,
      });
      _tagController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tag created successfully')),
    );
  }

  void _deleteTag(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tag'),
        content: const Text('Are you sure you want to delete this tag?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() {
                _tags.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editTag(int index) {
    final tag = _tags[index];
    _editTagController.text = tag['name'];
    Color tempColor = tag['color'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Tag'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editTagController,
                decoration: const InputDecoration(labelText: 'Tag Name'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _availableColors.map((color) {
                  return GestureDetector(
                    onTap: () => setDialogState(() => tempColor = color),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: color,
                      child: tempColor == color ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                setState(() {
                  _tags[index] = {
                    ...tag,
                    'name': _editTagController.text.trim(),
                    'color': tempColor,
                  };
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

  List<Map<String, dynamic>> get _filteredTags {
    if (_filterQuery.isEmpty) return _tags;
    return _tags.where((tag) => tag['name'].toLowerCase().contains(_filterQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1B385E)),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Tag Management',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1B385E)),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Create tag section
              _buildCreateTagSection(),
              const SizedBox(height: 32),

              // Active tags header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Active Tags',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1B385E)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'TOTAL ${_filteredTags.length} LABELS FOUND',
                      style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Filter bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: TextField(
                  controller: _filterController,
                  onChanged: (value) => setState(() => _filterQuery = value),
                  decoration: const InputDecoration(
                    hintText: 'Filter tags...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tag list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: _filteredTags.map((tag) {
                    final originalIndex = _tags.indexOf(tag);
                    return _buildTagCard(tag, originalIndex);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateTagSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create New Tag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B385E))),
            const Text('DEFINE A BRAND CATEGORY', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: const Color(0xFFEDF1F5), borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _tagController,
                decoration: const InputDecoration(hintText: 'e.g. Waterfront', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: _availableColors.map((color) {
                final isSelected = _selectedColor == color;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(shape: BoxShape.circle, border: isSelected ? Border.all(color: const Color(0xFF1B385E), width: 1.5) : null),
                    child: CircleAvatar(radius: 14, backgroundColor: color),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            CustomButton(onPressed: _createTag, text: 'Create Tag', icon: Icons.add),
          ],
        ),
      ),
    );
  }

  Widget _buildTagCard(Map<String, dynamic> tag, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(width: 6, height: 90, color: tag['color'] as Color),
          const SizedBox(width: 20),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(tag['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1B385E))),
              const SizedBox(height: 4),
              Text('${tag['properties']} PROPERTIES', style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(children: [
              _buildActionButton(icon: Icons.edit, label: 'Edit', onTap: () => _editTag(index)),
              const SizedBox(width: 8),
              _buildActionButton(icon: Icons.delete_outline, label: 'Delete', color: Colors.red.shade400, onTap: () => _deleteTag(index)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap, Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: const Color(0xFFF1F4F9), borderRadius: BorderRadius.circular(8)),
        child: Row(children: [Icon(icon, size: 14, color: color ?? const Color(0xFF1B385E)), const SizedBox(width: 4), Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color ?? const Color(0xFF1B385E)))]),
      ),
    );
  }
}

