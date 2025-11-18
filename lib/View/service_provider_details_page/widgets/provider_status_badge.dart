import 'package:flutter/material.dart';

class ProviderStatusBadge extends StatelessWidget {
  final String status;

  const ProviderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status.isEmpty) return const SizedBox.shrink();

    final isApproved = status.toLowerCase() == 'approved';
    final color = isApproved ? Colors.green : Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isApproved ? Icons.verified : Icons.pending,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 8),
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}