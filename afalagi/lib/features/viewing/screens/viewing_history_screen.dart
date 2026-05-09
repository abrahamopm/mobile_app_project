import 'package:afalagi/core/theme/theme.dart';
import 'package:afalagi/features/viewing/models/viewing_model.dart';
import 'package:afalagi/features/viewing/viewing_service.dart';
import 'package:afalagi/features/viewing/widgets/viewing_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewingHistoryScreen extends StatefulWidget {
  final String? propertyId;
  final String? clientId;

  const ViewingHistoryScreen({super.key, this.propertyId, this.clientId});

  @override
  State<ViewingHistoryScreen> createState() => _ViewingHistoryScreenState();
}

class _ViewingHistoryScreenState extends State<ViewingHistoryScreen> {
  late List<Viewing> _viewings;

  @override
  void initState() {
    super.initState();
    _loadViewings();
  }

  void _loadViewings() {
    _viewings = ViewingService.getViewings();
    if (widget.propertyId != null) {
      _viewings = _viewings.where((v) => v.propertyId == widget.propertyId).toList();
    }
    if (widget.clientId != null) {
      _viewings = _viewings.where((v) => v.clientId == widget.clientId).toList();
    }
  }

  void _deleteViewing(String id) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Viewing'),
        content: const Text('Are you sure you want to delete this viewing log?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () {
              setState(() {
                ViewingService.deleteViewing(id);
                _loadViewings();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Viewing deleted successfully')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _editViewing(Viewing viewing) {
    // Navigate to log viewing screen with viewing data
    context.push('/log-viewing', extra: viewing).then((_) {
      setState(() {
        _loadViewings();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MARKET INSIGHTS',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Activity Log',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.propertyId != null || widget.clientId != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (widget.propertyId != null)
                          _buildFilterChip('Property: ${widget.propertyId}', Icons.apartment),
                        if (widget.clientId != null) ...[
                          const SizedBox(width: 8),
                          _buildFilterChip('Client: ${widget.clientId}', Icons.person_outline),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _viewings.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          children: [
                            Icon(CupertinoIcons.doc_text, size: 64, color: Colors.grey[300]),
                            const SizedBox(height: 16),
                            Text(
                              'No viewings found',
                              style: TextStyle(color: Colors.grey[400], fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: _viewings.asMap().entries.map((entry) {
                        final index = entry.key;
                        final viewing = entry.value;
                        if (index == 0 && widget.propertyId == null && widget.clientId == null) {
                          return RecentViewingCard(
                            imageUrl: viewing.imageUrl,
                            title: viewing.propertyTitle,
                            date: viewing.date,
                            clientName: viewing.clientName,
                            clientInitials: viewing.clientName.isNotEmpty
                                ? viewing.clientName
                                    .split(' ')
                                    .where((e) => e.isNotEmpty)
                                    .map((e) => e[0])
                                    .join()
                                    .toUpperCase()
                                : '??',
                            onEdit: () => _editViewing(viewing),
                            onDelete: () => _deleteViewing(viewing.id),
                          );
                        }
                        return CompactViewingCard(
                          imageUrl: viewing.imageUrl,
                          title: viewing.propertyTitle,
                          clientName: viewing.clientName,
                          price: viewing.price,
                          date: viewing.date,
                          status: viewing.status,
                          onEdit: () => _editViewing(viewing),
                          onDelete: () => _deleteViewing(viewing.id),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
