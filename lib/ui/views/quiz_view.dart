import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/viewModels/quiz_view_model.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
import 'package:quiz_app/ui/widgets/network_image_hero.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';

class QuizView extends StatelessWidget {
  final Quiz quiz;

  const QuizView({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
      ),
      body: BaseView(
        builder: (BuildContext context, QuizViewModel model, Widget? _) =>
            Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: NetworkImageHero(
                image: quiz.imagePath,
                tag: quiz.id,
                onTap: model.onHeroTapped,
              ),
            ),
            VerticalSpace.small,
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    quiz.description,
                    softWrap: true,
                    style: Theme.of(context).textTheme.headline2!,
                  ),
                  VerticalSpace.medium,
                  ElevatedButton(
                    onPressed: () {
                      model.onStartPressed(
                        quiz,
                      );
                    },
                    child: Text(
                      'Start!',
                      style: TextStyle(fontSize: 24),
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(sw * 0.7, sh * 0.08),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
