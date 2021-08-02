import 'package:flutter/material.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';
import 'package:quiz_app/ui/widgets/network_image_hero.dart';

/// Stylized [GridTile] with a translucent header.
class QuizTile extends StatelessWidget {
  final String id;
  final String title;
  final String? imagePath;
  final int length;
  final int completed;
  final VoidCallback onTap;

  const QuizTile({
    Key? key,
    required this.id,
    required this.onTap,
    required this.length,
    this.title = '',
    this.imagePath,
    this.completed = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        // Creates an elevated effect.
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[6],
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // [ClipRRect] rounds out the corners of the image, this does not
            // happen automatically because even though the box appears rounded,
            // it is still actually a normal rectangle in shape, so the [Stack]
            // doesn't automatically clip its children.
            ClipRRect(
              child: (imagePath != null)
                  ? NetworkImageHero(image: imagePath!, tag: id, onTap: onTap)
                  : GestureDetector(onTap: onTap, child: Placeholder()),
              borderRadius: BorderRadius.circular(16),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                color: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    VerticalSpace.extraSmall,
                    ProgressBar(length, completed),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final int length;
  final int completed;

  const ProgressBar(this.length, this.completed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white,
              width: 150,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.tealAccent,
              width: (completed / length) * 150,
            ),
          ),
        ],
      ),
    );
  }
}
