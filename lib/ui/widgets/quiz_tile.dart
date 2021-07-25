import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/ui/widgets/network_image_hero.dart';
import 'package:quiz_app/core/models/api_models.dart';

/// Stylized [GridTile] with a translucent header.
class QuizTile extends StatelessWidget {
  final String id;
  final String title;
  final String? imagePath;
  final VoidCallback onTap;
  final BuildContext context;

  const QuizTile({
    Key? key,
    required this.id,
    required this.onTap,
    required this.context,
    this.title = '',
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(context) {
    // The number of completed questions.
    int completed = 0;
    // The total number of questions.
    int total = Provider.of<User>(context).progress.progress[id].length;
    // Calculated the number of completed questions by incrementing [completed]
    // whenever a question has been answered correctly.
    Provider.of<User>(context).progress.progress[id].forEach((_, elem) {
      if (elem == true) completed += 1;
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
        child: (imagePath != null && imagePath!.isNotEmpty)
            ? NetworkImageHero(image: imagePath!, tag: id, onTap: onTap)
            : Placeholder(),
        header: Opacity(
          opacity: 0.75,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 16, 4, 8),
            color: Colors.black,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // TODO: add quiz progress in footer
        footer: Opacity(
          opacity: 0.75,
          child: GridTileBar(
            backgroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 16,
                  color: Colors.green,
                  width: (completed / total) * 130,
                ),
                Container(
                  height: 16,
                  color: Colors.white,
                  width: (total - completed) / total * 130,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
