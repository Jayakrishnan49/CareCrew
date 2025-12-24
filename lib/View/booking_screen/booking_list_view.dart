import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_2/view/booking_screen/booking_card.dart';
import 'package:project_2/view/booking_screen/widgets/empty_booking_state.dart';
import 'package:project_2/widgets/shimmer/booking_card_shimmer.dart';

class BookingListView extends StatelessWidget {
  final String status;

  const BookingListView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(
        child: Text('Please login to view bookings'),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('my_bookings')
          .where('status', isEqualTo: status)
          // .orderBy('createdAt', descending: true) // Commented out until index is created
          .snapshots(),

          builder: (context, snapshot) {
  // SHOW SHIMMER
  if (!snapshot.hasData) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (_, __) => const BookingCardShimmer(),
    );
  }

  if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
  }

  if (snapshot.data!.docs.isEmpty) {
    return EmptyBookingState(status: status);
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
      final booking =
          snapshot.data!.docs[index].data() as Map<String, dynamic>;
      return BookingCard(booking: booking, status: status);
    },
  );
}

//       builder: (context, snapshot) {
//         // if (snapshot.connectionState == ConnectionState.waiting) {
//         //   return const Center(
//         //     child: CircularProgressIndicator(color: AppColors.primary),
//         //   );
//         // }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//   return ListView.builder(
//     padding: const EdgeInsets.all(16),
//     itemCount: 3, // number of shimmer cards
//     itemBuilder: (context, index) {
//       return const BookingCardShimmer();
//     },
//   );
// }


//         if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return EmptyBookingState(status: status);
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             final booking = snapshot.data!.docs[index].data() as Map<String, dynamic>;
//             return BookingCard(booking: booking, status: status);
//           },
//         );
//       },
    );
  }
}