import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundVideo extends StatelessWidget {
  const BackgroundVideo({
    super.key,
    required this.videoUrl,
    required this.blurSigma,
    required this.overlayOpacity,
  });

  final String videoUrl;
  final double blurSigma;
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2F3C35),
            Color(0xFF4A665A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            color: Colors.black.withValues(
              alpha: overlayOpacity.clamp(0, 1),
            ),
          ),
        ),
      ),
    );
  }
}
