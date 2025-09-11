import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AddSection extends StatelessWidget {
  const AddSection({super.key});

  @override
  Widget build(BuildContext context) {
    List images=[
      'assets/icons/dragon-ball-goku-orange-minimalist-desktop-wallpaper.jpg'
    ];
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        final imagePath = images[index];
        return InkWell(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => screens[index]),
          //   );
          // },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        animateToClosest: true,
        
      ),
    );
  }
}