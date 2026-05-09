import 'package:afalagi/core/theme/theme.dart';
import 'package:afalagi/core/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _selectedTags = [];
  bool _isAvailable = true;

  final List<String> _availableTags = [
    "Luxury",
    "Modern",
    "Garden",
    "Pool",
    "Security",
    "Parking",
    "Furnished"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Add Property',
          style: TextStyle(
            fontFamily: 'Figtree',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Asymmetric Hero Section (Visuals) Placeholder
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined,
                        size: 48, color: Colors.grey[600]),
                    const SizedBox(height: 8),
                    Text(
                      "Upload Property Visuals",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("Basic Information"),
                    _buildTextField("Title", "e.g. Modern Villa in Bole"),
                    const SizedBox(height: 16),
                    _buildTextField("Description", "Describe the property...",
                        maxLines: 3),

                    const SizedBox(height: 24),
                    _buildSectionHeader("Price Input Section"),
                    _buildTextField("Price", "e.g. 1500000",
                        keyboardType: TextInputType.number, prefixText: " birr "),

                    const SizedBox(height: 24),
                    _buildSectionHeader("Location Details"),
                    _buildTextField("Address", "e.g. Churchill Ave"),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildTextField("City", "e.g. Addis")),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildTextField("Zip Code", "e.g. 1000")),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _buildSectionHeader("Rooms & Layout"),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField("Bedrooms", "3",
                                keyboardType: TextInputType.number)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildTextField("Bathrooms", "2",
                                keyboardType: TextInputType.number)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildTextField("SQM", "120",
                                keyboardType: TextInputType.number)),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _buildSectionHeader("Status Selection"),
                    SwitchListTile(
                      title: const Text("Property Availability"),
                      subtitle: Text(_isAvailable ? "Available" : "Sold/Rented"),
                      value: _isAvailable,
                      onChanged: (val) => setState(() => _isAvailable = val),
                      activeColor: AppTheme.primaryColor,
                    ),

                    const SizedBox(height: 24),
                    _buildSectionHeader("Tags / Pills"),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableTags.map((tag) {
                        final isSelected = _selectedTags.contains(tag);
                        return FilterChip(
                          label: Text(tag),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedTags.add(tag);
                              } else {
                                _selectedTags.remove(tag);
                              }
                            });
                          },
                          selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                          checkmarkColor: AppTheme.primaryColor,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? AppTheme.primaryColor
                                : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : null,
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 40),
                    CustomButton(
                      text: "Save Property",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Save logic
                          context.pop();
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {int maxLines = 1,
      TextInputType keyboardType = TextInputType.text,
      String? prefixText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixText: prefixText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }
}
