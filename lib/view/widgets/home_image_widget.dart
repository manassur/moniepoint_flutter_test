import 'dart:ui';

import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({
    required this.assetPath,
    required this.sliderWidth,
    this.sliderHeight = 40,
    required this.sliderText,
    required this.textOpacity,
    this.sliderTextAlignment = Alignment.centerLeft,
    this.height,
    super.key,
  });

  final String assetPath;
  final double sliderWidth;
  final double sliderHeight;
  final String sliderText;
  final double textOpacity;
  final Alignment sliderTextAlignment;
  final double? height;

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: double.infinity,
      height: widget.height,
      padding: const EdgeInsets.only(
        left: 10,
        bottom: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage(
            widget.assetPath,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2, right: 2),
        width: widget.sliderWidth + widget.sliderHeight,
        height: widget.sliderHeight,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        child: Stack(
          children: [
            // Apply the blur effect to the container
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: const Color(0xffA5957E)
                        .withAlpha(140), // Semi-transparent color
                  ),
                ),
              ),
            ),
            Align(
              alignment: widget.sliderTextAlignment,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedOpacity(
                  opacity: widget.textOpacity,
                  duration: const Duration(
                      milliseconds: 300), // Adjust the duration as needed
                  curve: Curves.easeInOut, // Smooth transition
                  child: Text(
                    widget.sliderText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff232220),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                radius: widget.sliderHeight / 2,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.chevron_right,
                  size: 15,
                  color: Color(0xffA5957E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
