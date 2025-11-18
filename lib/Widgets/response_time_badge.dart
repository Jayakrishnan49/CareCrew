// import 'package:flutter/material.dart';
// import 'package:project_2/model/service_model.dart';

// /// Simple badge to show provider's response time
// /// Add this to your provider card widget
// class ResponseTimeBadge extends StatelessWidget {
//   final ServiceProviderModel provider;

//   const ResponseTimeBadge({
//     super.key,
//     required this.provider,
//   });

//   Color _getColor() {
//     if (provider.averageResponseTimeMinutes == null) return Colors.grey;
//     if (provider.averageResponseTimeMinutes! < 30) return Colors.green;
//     if (provider.averageResponseTimeMinutes! < 120) return Colors.lightGreen;
//     if (provider.averageResponseTimeMinutes! < 1440) return Colors.orange;
//     return Colors.red;
//   }

//   IconData _getIcon() {
//     if (provider.averageResponseTimeMinutes == null) return Icons.new_releases;
//     if (provider.averageResponseTimeMinutes! < 30) return Icons.flash_on;
//     if (provider.averageResponseTimeMinutes! < 120) return Icons.speed;
//     return Icons.schedule;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: _getColor().withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _getColor(), width: 1),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(_getIcon(), size: 14, color: _getColor()),
//           const SizedBox(width: 4),
//           Text(
//             provider.formattedResponseTime,
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               color: _getColor(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:project_2/model/service_model.dart';

/// Modern Response Time Badge with gradient and animations
class ResponseTimeBadge extends StatelessWidget {
  final ServiceProviderModel provider;
  final bool compact;

  const ResponseTimeBadge({
    super.key,
    required this.provider,
    this.compact = false,
  });

  Color _getPrimaryColor() {
    if (provider.averageResponseTimeMinutes == null) return Colors.grey.shade400;
    if (provider.averageResponseTimeMinutes! < 30) return const Color(0xFF10B981); // Green
    if (provider.averageResponseTimeMinutes! < 120) return const Color(0xFF3B82F6); // Blue
    if (provider.averageResponseTimeMinutes! < 1440) return const Color(0xFFF59E0B); // Amber
    return const Color(0xFFEF4444); // Red
  }

  Color _getSecondaryColor() {
    if (provider.averageResponseTimeMinutes == null) return Colors.grey.shade300;
    if (provider.averageResponseTimeMinutes! < 30) return const Color(0xFF34D399);
    if (provider.averageResponseTimeMinutes! < 120) return const Color(0xFF60A5FA);
    if (provider.averageResponseTimeMinutes! < 1440) return const Color(0xFFFBBF24);
    return const Color(0xFFF87171);
  }

  IconData _getIcon() {
    if (provider.averageResponseTimeMinutes == null) return Icons.fiber_new_rounded;
    if (provider.averageResponseTimeMinutes! < 30) return Icons.bolt_rounded;
    if (provider.averageResponseTimeMinutes! < 120) return Icons.timer_rounded;
    return Icons.schedule_rounded;
  }

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _buildCompactBadge();
    }
    return _buildFullBadge();
  }

  Widget _buildCompactBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getPrimaryColor().withOpacity(0.15),
            _getSecondaryColor().withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getPrimaryColor().withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            size: 12,
            color: _getPrimaryColor(),
          ),
          const SizedBox(width: 3),
          Text(
            provider.formattedResponseTime,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _getPrimaryColor(),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getPrimaryColor().withOpacity(0.12),
            _getSecondaryColor().withOpacity(0.12),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getPrimaryColor().withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _getPrimaryColor().withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _getPrimaryColor().withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIcon(),
              size: 14,
              color: _getPrimaryColor(),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            provider.formattedResponseTime,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _getPrimaryColor(),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Detailed Response Time Card with statistics
class ResponseTimeCard extends StatelessWidget {
  final ServiceProviderModel provider;

  const ResponseTimeCard({super.key, required this.provider});

  Color _getPrimaryColor() {
    if (provider.averageResponseTimeMinutes == null) return Colors.grey.shade400;
    if (provider.averageResponseTimeMinutes! < 30) return const Color(0xFF10B981);
    if (provider.averageResponseTimeMinutes! < 120) return const Color(0xFF3B82F6);
    if (provider.averageResponseTimeMinutes! < 1440) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  IconData _getIcon() {
    if (provider.averageResponseTimeMinutes == null) return Icons.fiber_new_rounded;
    if (provider.averageResponseTimeMinutes! < 30) return Icons.bolt_rounded;
    if (provider.averageResponseTimeMinutes! < 120) return Icons.timer_rounded;
    return Icons.schedule_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            _getPrimaryColor().withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getPrimaryColor().withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _getPrimaryColor().withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getPrimaryColor().withOpacity(0.2),
                        _getPrimaryColor().withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.access_time_rounded,
                    size: 24,
                    color: _getPrimaryColor(),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Response Time',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2937),
                          letterSpacing: 0.3,
                        ),
                      ),
                      Text(
                        'How fast they respond',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Main Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Average Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Average Time:',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            provider.formattedResponseTime,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: _getPrimaryColor(),
                              height: 1,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              _getIcon(),
                              size: 24,
                              color: _getPrimaryColor().withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getPrimaryColor(),
                        _getPrimaryColor().withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _getPrimaryColor().withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getIcon(),
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        provider.responseSpeedBadge,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Total Responses
            if (provider.totalResponses > 0) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getPrimaryColor().withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getPrimaryColor().withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: _getPrimaryColor(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Based on ${provider.totalResponses} response${provider.totalResponses > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: _getPrimaryColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}