import 'package:flutter/material.dart';

/// Utility class to provide a placeholder with a hero transition.
class PlaceholderHero extends StatelessWidget {
  /// Optional paramter to specify the final width / height
  /// of the image.
  final double? width, height;

  /// Closure that will be called on tap.
  ///
  /// Must either push or pop a route otherwise the hero animation
  /// will not run.
  final VoidCallback onTap;

  /// Must only be shared by two PlaceholderHero widgets.
  final String tag;

  const PlaceholderHero({
    Key? key,
    required this.tag,
    required this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? null,
      height: height ?? null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Hero(
          tag: tag,
          child: Placeholder(),
        ),
      ),
    );
  }
}
