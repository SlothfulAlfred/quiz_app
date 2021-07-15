import 'package:flutter/material.dart';
import 'package:quiz_app/ui/widgets/network_image_hero.dart';

/// Stylized [GridTile] with a translucent header.
class QuizTile extends StatelessWidget {
  final String id;
  final String title;
  final String? imagePath;
  final VoidCallback onTap;

  const QuizTile({
    Key? key,
    required this.id,
    required this.onTap,
    this.title = '',
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
        child: (imagePath != null)
            ? NetworkImageHero(image: imagePath!, tag: id, onTap: onTap)
            : Placeholder(),
        header: Opacity(opacity: 0.75, child: Text(title)),
        // TODO: add quiz progress in footer
      ),
    );
  }
}
