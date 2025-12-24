// import 'package:flutter/material.dart';
// import 'package:project_2/widgets/shimmer/app_shimmer.dart';

// class BookingCardShimmer extends StatelessWidget {
//   const BookingCardShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppShimmer(
//       child: Container(
//         height: 230,
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookingCardShimmer extends StatelessWidget {
  const BookingCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Image shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _line(width: double.infinity, height: 18),
                const SizedBox(height: 12),
                _line(width: 180, height: 14),
                const SizedBox(height: 20),

                Row(
                  children: [
                    _circle(52),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          _line(width: double.infinity, height: 14),
                          const SizedBox(height: 6),
                          _line(width: 120, height: 12),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                _line(width: double.infinity, height: 60),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _line(width: 80, height: 20),
                    _line(width: 120, height: 44),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _circle(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
