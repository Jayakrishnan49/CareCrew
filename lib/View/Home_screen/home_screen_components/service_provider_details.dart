// import 'package:flutter/material.dart';
// import 'package:project_2/View/home_screen/home_screen_components/service_provider_list_section/service_provider_list_section.dart';

// class ServiceProviderDetails extends StatelessWidget {
//   final ServiceProvider provider;

//   const ServiceProviderDetails({super.key, required this.provider});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(provider.name)),
//       body: Column(
//         children: [
//           Hero(
//             tag: provider.name, // must match the tag from card
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 provider.imageUrl,
//                 height: 250,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             provider.name,
//             style: const TextStyle(
//                 fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           Text(provider.workType,
//               style: TextStyle(color: Colors.grey[700], fontSize: 16)),
//           const SizedBox(height: 8),
//           Text("⭐ ${provider.rating}   •   ${provider.experience} yrs exp."),
//           const SizedBox(height: 20),
//           Text("Location: ${provider.location}"),
//         ],
//       ),
//     );
//   }
// }
