import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewModels/home_view_model.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
import 'package:quiz_app/ui/widgets/quiz_tile.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final HomeViewModel model = locator<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BaseView(
        builder: (BuildContext context, HomeViewModel model, Widget? chlild) {
          if (model.state == ViewState.idle) {
            return Center(
              child: GridView.count(
                // TODO: make this grid responsive UI
                crossAxisCount: 2,
                physics: BouncingScrollPhysics(),
                // Take the quizzes from the model and map them all to [QuizTile]s
                children: model.quiz
                    .map<QuizTile>((quiz) => QuizTile(
                          id: quiz.id,
                          imagePath: quiz.imagePath,
                          title: quiz.title,
                          // Anonymous function that  passes the current quiz
                          // to heroTapped. This makes the function is a VoidCallback
                          // and can therefore be used in [GestureDetector] onTap callbacks.
                          onTap: () {
                            model.heroTapped(quiz);
                          },
                        ))
                    .toList(),
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 24),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
