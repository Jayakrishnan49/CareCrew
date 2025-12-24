import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget categoryShimmer() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (_, __) {
        return Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: const CircleAvatar(radius: 30),
            ),
            const SizedBox(height: 8),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 10,
                width: 40,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    ),
  );
}
