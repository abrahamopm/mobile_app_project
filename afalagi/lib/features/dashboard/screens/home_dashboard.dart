import 'package:flutter/material.dart';
import 'package:afalagi/core/theme/theme.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(),
            const SizedBox(height: 24),
            _buildStatsCards(),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildRecentActivityHeader(),
            const SizedBox(height: 12),
            _buildRecentActivityList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Morning, Dawit',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF001F3F),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Your portfolio overview for today in Addis Ababa.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Column(
      children: [
        _buildLargeStatCard(
          'TOTAL PROPERTIES',
          '42',
          '+12%',
          const Color(0xFFE0F2F1),
          const Color(0xFF005A6E),
        ),
        const SizedBox(height: 16),
        _buildLargeStatCard(
          'ACTIVE CLIENTS',
          '128',
          'ACTIVE',
          const Color(0xFFF3F4F6),
          const Color(0xFF001F3F),
          showAvatars: true,
        ),
        const SizedBox(height: 16),
        _buildLargeStatCard(
          'TODAY\'S VIEWINGS',
          '6',
          '',
          const Color(0xFFFFF9C4),
          const Color(0xFFB8860B),
        ),
      ],
    );
  }

  Widget _buildLargeStatCard(String title, String value, String badgeText, Color bgColor, Color iconColor, {bool showAvatars = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.business_center, color: iconColor, size: 20),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001F3F),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (badgeText.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeText == 'ACTIVE' ? const Color(0xFFE8F5E9) : const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      color: badgeText == 'ACTIVE' ? Colors.green : const Color(0xFF005A6E),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (showAvatars) ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: 60,
                  height: 30,
                  child: Stack(
                    children: [
                      const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=1')),
                      const Positioned(left: 15, child: CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=2'))),
                      Positioned(left: 30, child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        child: const Center(child: Icon(Icons.add, color: Colors.white, size: 12)),
                      )),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        _buildActionButton('Add Property', Icons.add_home_outlined, const Color(0xFF001F3F)),
        const SizedBox(height: 12),
        _buildActionButton('Add Client', Icons.person_add_outlined, Colors.white, textColor: const Color(0xFF001F3F)),
        const SizedBox(height: 12),
        _buildActionButton('Log Viewing', Icons.calendar_today_outlined, Colors.white, textColor: const Color(0xFF001F3F)),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color bgColor, {Color textColor = Colors.white}) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: bgColor == Colors.white ? Border.all(color: Colors.grey.shade200) : null,
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001F3F)),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('View All', style: TextStyle(fontSize: 12, color: Color(0xFF005A6E))),
        ),
      ],
    );
  }

  Widget _buildRecentActivityList() {
    return Column(
      children: [
        _buildActivityTile(
          'Koye Feche Penthouse',
          'Listing updated to ETB 12,500,000',
          '3h ago',
          Icons.apartment,
          const Color(0xFFB8860B),
        ),
        const SizedBox(height: 12),
        _buildActivityTile(
          'Abebe Kebede',
          'Inquired about Bole High-Rise',
          '5h ago',
          Icons.person_outline,
          const Color(0xFFE0F2F1),
          iconColor: const Color(0xFF005A6E),
        ),
      ],
    );
  }

  Widget _buildActivityTile(String title, String subtitle, String time, IconData icon, Color iconBg, {Color iconColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF001F3F))),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: Colors.grey[400], fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final activities = [
                {'title': 'New Viewing Scheduled', 'subtitle': 'Bole Apartment - 2:00 PM', 'time': '2h ago'},
                {'title': 'Property Updated', 'subtitle': 'CMC Villa price changed', 'time': '4h ago'},
                {'title': 'New Client Added', 'subtitle': 'Abebe Kebede', 'time': '1d ago'},
              ];
              return ListTile(
                title: Text(activities[index]['title']!),
                subtitle: Text(activities[index]['subtitle']!),
                trailing: Text(
                  activities[index]['time']!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
