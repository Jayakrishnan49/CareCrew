
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:project_2/constants/app_color.dart';
// import 'package:project_2/widgets/custom_button.dart';

// class BookingDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> booking;
//   final String status;

//   const BookingDetailScreen({
//     super.key,
//     required this.booking,
//     required this.status,
//   });

//   String _formatDate(dynamic timestamp) {
//     DateTime date;
//     if (timestamp is Timestamp) {
//       date = timestamp.toDate();
//     } else if (timestamp is DateTime) {
//       date = timestamp;
//     } else {
//       return 'N/A';
//     }
//     return '${date.day} ${_getMonthName(date.month)}, ${date.year}';
//   }

//   String _getMonthName(int month) {
//     const months = [
//       'January', 'February', 'March', 'April', 'May', 'June',
//       'July', 'August', 'September', 'October', 'November', 'December'
//     ];
//     return months[month - 1];
//   }

//   String _formatTime(String? time) {
//     if (time == null) return 'N/A';
//     return time;
//   }

//   String _formatDateTime(dynamic timestamp) {
//     DateTime date;
//     if (timestamp is Timestamp) {
//       date = timestamp.toDate();
//     } else if (timestamp is DateTime) {
//       date = timestamp;
//     } else {
//       return 'N/A';
//     }
//     return '${date.day} ${_getMonthName(date.month)}, ${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return const Color(0xFF4CAF50);
//       case 'accepted':
//         return const Color(0xFF2196F3);
//       case 'pending':
//         return const Color(0xFFFF9800);
//       case 'rejected':
//         return const Color(0xFFF44336);
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final imageUrls = booking['imageUrls'] as List<dynamic>? ?? [];
//     final notes = booking['notes'] as String? ?? '';
//     final responseTimeMinutes = booking['responseTimeMinutes'] as int?;
//     final address = booking['address'] as String? ?? '';
//     final requestSentAt = booking['requestSentAt'];
//     final responseAt = booking['responseAt'];

//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Booking Details',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Card with Booking ID and Status
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Booking ID',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             '#${booking['id'] ?? '123'}',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         decoration: BoxDecoration(
//                           color: _getStatusColor(status),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               status.toLowerCase() == 'completed'
//                                   ? Icons.check_circle
//                                   : status.toLowerCase() == 'pending'
//                                       ? Icons.access_time
//                                       : status.toLowerCase() == 'accepted'
//                                           ? Icons.thumb_up
//                                           : Icons.cancel,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               status.toUpperCase(),
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Service Information Card
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // ClipRRect(
//                       //   borderRadius: BorderRadius.circular(12),
//                       //   child: Image.network(
//                       //     booking['serviceImage'] ?? 'https://via.placeholder.com/100',
//                       //     width: 90,
//                       //     height: 90,
//                       //     fit: BoxFit.cover,
//                       //     errorBuilder: (context, error, stackTrace) {
//                       //       return Container(
//                       //         width: 90,
//                       //         height: 90,
//                       //         decoration: BoxDecoration(
//                       //           color: Colors.grey.shade200,
//                       //           borderRadius: BorderRadius.circular(12),
//                       //         ),
//                       //         child: const Icon(Icons.image, color: Colors.grey, size: 40),
//                       //       );
//                       //     },
//                       //   ),
//                       // ),
//                       ClipRRect(
//   borderRadius: BorderRadius.circular(12),
//   child: Image.network(
//     booking['serviceImage'] ?? '',
//     width: 90,
//     height: 90,
//     fit: BoxFit.cover,

//     // ✅ PLACEHOLDER (while loading)
//     loadingBuilder: (context, child, loadingProgress) {
//       if (loadingProgress == null) return child;

//       return Container(
//         width: 90,
//         height: 90,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: const Icon(
//           Icons.image,
//           color: Colors.grey,
//           size: 32,
//         ),
//       );
//     },

//     // ✅ ERROR FALLBACK
//     errorBuilder: (context, error, stackTrace) {
//       return Container(
//         width: 90,
//         height: 90,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: const Icon(
//           Icons.broken_image,
//           color: Colors.grey,
//           size: 32,
//         ),
//       );
//     },
//   ),
// ),

//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               booking['serviceType'] ?? 'Service',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             _buildIconInfoRow(
//                               Icons.calendar_today,
//                               _formatDate(booking['date']),
//                             ),
//                             const SizedBox(height: 8),
//                             _buildIconInfoRow(
//                               Icons.access_time,
//                               _formatTime(booking['time']),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Divider(color: Colors.grey.shade200, height: 1),
//                   const SizedBox(height: 16),
//                   _buildIconInfoRow(
//                     Icons.location_on,
//                     address.isNotEmpty ? address : 'No address provided',
//                   ),
//                 ],
//               ),
//             ),

//             // const SizedBox(height: 12),

//             // User Information Card
//             // Container(
//             //   width: double.infinity,
//             //   margin: const EdgeInsets.symmetric(horizontal: 16),
//             //   padding: const EdgeInsets.all(20),
//             //   decoration: BoxDecoration(
//             //     color: Colors.white,
//             //     borderRadius: BorderRadius.circular(12),
//             //     boxShadow: [
//             //       BoxShadow(
//             //         color: Colors.black.withOpacity(0.05),
//             //         blurRadius: 10,
//             //         offset: const Offset(0, 2),
//             //       ),
//             //     ],
//             //   ),
//               // child: Column(
//               //   crossAxisAlignment: CrossAxisAlignment.start,
//               //   children: [
//               //     const Text(
//               //       'Customer Information',
//               //       style: TextStyle(
//               //         fontSize: 16,
//               //         fontWeight: FontWeight.bold,
//               //         color: Colors.black87,
//               //       ),
//               //     ),
//               //     const SizedBox(height: 16),
//               //     _buildDetailRow('Name', booking['userName'] ?? 'N/A'),
//               //     const SizedBox(height: 12),
//               //     _buildDetailRow('Phone', booking['userPhone'] ?? 'N/A'),
//               //     const SizedBox(height: 12),
//               //     _buildDetailRow('Email', booking['userEmail'] ?? 'N/A'),
//               //   ],
//               // ),
//             // ),

//             const SizedBox(height: 12),

//             // Images Section (if available)
//             if (imageUrls.isNotEmpty) ...[
//               Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Attached Images',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     SizedBox(
//                       height: 100,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: imageUrls.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               _showImageDialog(context, imageUrls[index].toString());
//                             },
//                             child: Container(
//                               width: 100,
//                               margin: const EdgeInsets.only(right: 12),
//                               // child: ClipRRect(
//                               //   borderRadius: BorderRadius.circular(12),
//                               //   child: Image.network(
//                               //     imageUrls[index].toString(),
//                               //     fit: BoxFit.cover,
//                               //     errorBuilder: (context, error, stackTrace) {
//                               //       return Container(
//                               //         decoration: BoxDecoration(
//                               //           color: Colors.grey.shade200,
//                               //           borderRadius: BorderRadius.circular(12),
//                               //         ),
//                               //         child: const Icon(
//                               //           Icons.broken_image,
//                               //           color: Colors.grey,
//                               //           size: 40,
//                               //         ),
//                               //       );
//                               //     },
//                               //   ),
//                               // ),
//                              child:  ClipRRect(
//   borderRadius: BorderRadius.circular(12),
//   child: Image.network(
//     imageUrls[index].toString(),
//     width: 100,
//     height: 100,
//     fit: BoxFit.cover,

//     // ✅ PLACEHOLDER (while loading)
//     loadingBuilder: (context, child, loadingProgress) {
//       if (loadingProgress == null) return child;

//       return Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: const Icon(
//           Icons.image,
//           color: Colors.grey,
//           size: 32,
//         ),
//       );
//     },

//     // ✅ ERROR FALLBACK
//     errorBuilder: (context, error, stackTrace) {
//       return Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: const Icon(
//           Icons.broken_image,
//           color: Colors.grey,
//           size: 32,
//         ),
//       );
//     },
//   ),
// ),

//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),
//             ],

//             // Notes Section (if available)
//             if (notes.isNotEmpty) ...[
//               Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Additional Notes',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       notes,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade700,
//                         height: 1.6,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),
//             ],

//             // Timing Details Section
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Timing Details',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDetailRow(
//                     'Request Sent',
//                     _formatDateTime(requestSentAt),
//                   ),
//                   if (responseAt != null) ...[
//                     const SizedBox(height: 12),
//                     _buildDetailRow(
//                       'Response Received',
//                       _formatDateTime(responseAt),
//                     ),
//                   ],
//                   if (responseTimeMinutes != null) ...[
//                     const SizedBox(height: 16),
//                     Divider(color: Colors.grey.shade200, height: 1),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: AppColors.primary.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: const Icon(
//                                 Icons.timer,
//                                 color: AppColors.primary,
//                                 size: 20,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             const Text(
//                               'Response Time',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           '$responseTimeMinutes min',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.primary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ],
//               ),
//             ),

//             const SizedBox(height: 12),

//             // About Service Provider Section
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Service Provider',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 32,
//                         backgroundImage: NetworkImage(
//                           booking['providerPhoto'] ?? 'https://via.placeholder.com/100',
//                         ),
//                         backgroundColor: Colors.grey.shade200,
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               booking['providerName'] ?? 'Provider',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               booking['providerTitle'] ?? 'Service Expert',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 ...List.generate(
//                                   5,
//                                   (index) => const Icon(
//                                     Icons.star,
//                                     color: Colors.amber,
//                                     size: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   booking['providerRating']?.toString() ?? '4.5',
//                                   style: const TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomButton(
//                           borderColor: AppColors.buttonColor,

//                           text: 'Call',
//                           onTap: () {
//                             // Handle call
//                           },
//                           // color: AppColors.primary,
//                           height: 50,
//                           borderRadius: 10,
//                           icon: const Icon(Icons.phone, size: 18),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: CustomButton(
//                           text: 'Chat',
//                           onTap: () {
//                             // Handle chat
//                           },
//                           color: Colors.white,
//                           textColor: AppColors.primary,
//                           borderColor: AppColors.buttonColor,
//                           height: 50,
//                           borderRadius: 10,
//                           icon: const Icon(Icons.chat_bubble_outline, size: 18),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Price Detail Section
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Payment Details',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Total Amount',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       Text(
//                         '₹${booking['price'] ?? '0.00'}',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF4CAF50).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(6),
//                       border: Border.all(
//                         color: const Color(0xFF4CAF50).withOpacity(0.3),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         Icon(
//                           Icons.check_circle,
//                           color: Color(0xFF4CAF50),
//                           size: 16,
//                         ),
//                         SizedBox(width: 6),
//                         Text(
//                           'Payment Completed',
//                           style: TextStyle(
//                             color: Color(0xFF4CAF50),
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildIconInfoRow(IconData icon, String value) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           size: 16,
//           color: Colors.grey.shade600,
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade700,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 100,
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showImageDialog(BuildContext context, String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: Stack(
//           children: [
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       padding: const EdgeInsets.all(40),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Icon(
//                         Icons.broken_image_rounded,
//                         color: Colors.grey,
//                         size: 60,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 10,
//               right: 10,
//               child: GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.black54,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: const Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/widgets/custom_button.dart';

class BookingDetailScreen extends StatelessWidget {
  final Map<String, dynamic> booking;
  final String status;

  const BookingDetailScreen({
    super.key,
    required this.booking,
    required this.status,
  });

  String _formatDate(dynamic timestamp) {
    DateTime date;
    if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else if (timestamp is DateTime) {
      date = timestamp;
    } else {
      return 'N/A';
    }
    return '${date.day} ${_getMonthName(date.month)}, ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _formatTime(String? time) {
    if (time == null) return 'N/A';
    return time;
  }

  String _formatDateTime(dynamic timestamp) {
    DateTime date;
    if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else if (timestamp is DateTime) {
      date = timestamp;
    } else {
      return 'N/A';
    }
    return '${date.day} ${_getMonthName(date.month)}, ${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF4CAF50);
      case 'accepted':
        return const Color(0xFF2196F3);
      case 'pending':
        return const Color(0xFFFF9800);
      case 'rejected':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrls = booking['imageUrls'] as List<dynamic>? ?? [];
    final notes = booking['notes'] as String? ?? '';
    final responseTimeMinutes = booking['responseTimeMinutes'] as int?;
    final address = booking['address'] as String? ?? '';
    final requestSentAt = booking['requestSentAt'];
    final responseAt = booking['responseAt'];
    final rejectionReason = booking['rejectionReason'] as String?; 

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Booking Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card with Booking ID and Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking ID',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '#${booking['id'] ?? '123'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              status.toLowerCase() == 'completed'
                                  ? Icons.check_circle
                                  : status.toLowerCase() == 'pending'
                                      ? Icons.access_time
                                      : status.toLowerCase() == 'accepted'
                                          ? Icons.thumb_up
                                          : Icons.cancel,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rejection Reason Section (only show if status is rejected)
            if (status.toLowerCase() == 'rejected' && rejectionReason != null && rejectionReason.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3F3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.rejected.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.rejected.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.rejected,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Rejection Reason',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.rejected,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      rejectionReason,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),

            // Service Information Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          booking['serviceImage'] ?? '',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 32,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                                size: 32,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['serviceType'] ?? 'Service',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildIconInfoRow(
                              Icons.calendar_today,
                              _formatDate(booking['date']),
                            ),
                            const SizedBox(height: 8),
                            _buildIconInfoRow(
                              Icons.access_time,
                              _formatTime(booking['time']),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.shade200, height: 1),
                  const SizedBox(height: 16),
                  _buildIconInfoRow(
                    Icons.location_on,
                    address.isNotEmpty ? address : 'No address provided',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Images Section (if available)
            if (imageUrls.isNotEmpty) ...[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Attached Images',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _showImageDialog(context, imageUrls[index].toString());
                            },
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imageUrls[index].toString(),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Notes Section (if available)
            if (notes.isNotEmpty) ...[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Additional Notes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      notes,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Timing Details Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Timing Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Request Sent',
                    _formatDateTime(requestSentAt),
                  ),
                  if (responseAt != null) ...[
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Response Received',
                      _formatDateTime(responseAt),
                    ),
                  ],
                  if (responseTimeMinutes != null) ...[
                    const SizedBox(height: 16),
                    Divider(color: Colors.grey.shade200, height: 1),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.timer,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Response Time',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$responseTimeMinutes min',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            // About Service Provider Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Service Provider',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey.shade200,
                        child: ClipOval(
                          child: Image.network(
                            booking['providerPhoto'] ?? '',
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Icon(Icons.person, color: Colors.white);
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, color: Colors.white);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['providerName'] ?? 'Provider',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              booking['serviceType'] ?? 'Service Expert',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  booking['providerRating']?.toString() ?? '4.5',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          borderColor: AppColors.buttonColor,
                          text: 'Call',
                          onTap: () {
                            // Handle call
                          },
                          height: 50,
                          borderRadius: 10,
                          icon: const Icon(Icons.phone, size: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'Chat',
                          onTap: () {
                            // Handle chat
                          },
                          color: Colors.white,
                          textColor: AppColors.primary,
                          borderColor: AppColors.buttonColor,
                          height: 50,
                          borderRadius: 10,
                          icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Price Detail Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '₹${booking['price'] ?? '0.00'}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF4CAF50).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF4CAF50),
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Payment Completed',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildIconInfoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.broken_image_rounded,
                        color: Colors.grey,
                        size: 60,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}