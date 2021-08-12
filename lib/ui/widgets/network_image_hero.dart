import 'package:flutter/material.dart';

/// Utility class to provide a network image with a hero transition.
///
/// [image] must be a url so that it can be passed into [Image.network].
class NetworkImageHero extends StatelessWidget {
  /// The path to the image which should be animated.
  final String image;

  /// A unique identifier for a pair of [Hero] widgets.
  final String tag;

  /// Optional paramter to specify the final width / height
  /// of the image.
  final double? width, height;

  /// Closure that will be called on tap.
  ///
  /// Must either push or pop a route otherwise the hero animation
  /// will not run.
  final VoidCallback onTap;

  const NetworkImageHero({
    Key? key,
    required this.image,
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
        onTap: onTap,
        child: Container(
          color: Colors.white,
          constraints: BoxConstraints.expand(),
          child: FittedBox(
            child: FadeInImage(
              image: NetworkImage(image),
              placeholder: AssetImage('assets/loading.gif'),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
