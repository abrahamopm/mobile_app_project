import 'package:flutter/material.dart';
import 'package:afalagi/core/theme/theme.dart';

void main() => runApp(const DeleteAccountApp());

class DeleteAccountApp extends StatelessWidget {
  const DeleteAccountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Account',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const DeleteAccountScreen(),
    );
  }
}

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _confirmController = TextEditingController();
  bool _isDeleteEnabled = false;

  @override
  void initState() {
    super.initState();
    _confirmController.addListener(() {
      setState(() {
        _isDeleteEnabled = _confirmController.text.trim().toUpperCase() == 'DELETE';
      });
    });
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B385E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Main Card
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  children: [
                    // Red Icon
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF1F1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_remove_outlined, size: 40, color: Color(0xFFE53E3E)),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Delete Account',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B385E)),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
                        children: const [
                          TextSpan(text: "We're sorry to see you go. Please understand that this action is "),
                          TextSpan(
                            text: "permanent",
                            style: TextStyle(color: Color(0xFFE53E3E), fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: " and cannot be undone."),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Info Cards
                    _buildInfoCard(
                      Icons.home_work_outlined,
                      'Properties',
                      'All your active listings will be removed.',
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      Icons.group_outlined,
                      'Leads',
                      'Your entire database of potential buyers will be deleted.',
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      Icons.remove_red_eye_outlined,
                      'Analytics & Viewings',
                      'Historical performance data and scheduled viewings will be wiped from the Afalagi ecosystem.',
                    ),
                    const SizedBox(height: 32),

                    // Confirmation Section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Type 'DELETE' to confirm",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9ECEF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _confirmController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2.0, color: Color(0xFF1B385E)),
                        decoration: const InputDecoration(
                          hintText: 'DELETE',
                          hintStyle: TextStyle(color: Colors.black26, letterSpacing: 2.0),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Delete Button
                    _buildCustomButton(
                      text: 'Delete My Account',
                      onPressed: _isDeleteEnabled ? () {} : null,
                      backgroundColor: _isDeleteEnabled ? const Color(0xFF2D3436) : Colors.grey.shade300,
                      textColor: Colors.white,
                      icon: Icons.delete_outline,
                      hasShadow: _isDeleteEnabled,
                    ),
                    const SizedBox(height: 12),

                    // Go Back Button
                    _buildCustomButton(
                      text: 'Go back',
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: const Color(0xFFE9ECEF),
                      textColor: Colors.black87,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: const Color(0xFF1B385E)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomButton({
    required String text,
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
    bool hasShadow = false,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: hasShadow ? [
          BoxShadow(
            color: const Color(0xFFE53E3E).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ] : [],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
