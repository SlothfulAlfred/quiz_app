import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/viewModels/questions_view_model.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';
import 'package:quiz_app/ui/widgets/choices_grid.dart';
import 'package:quiz_app/ui/router.dart';
import 'package:quiz_app/ui/routing_constants.dart';

class QuestionsView extends StatelessWidget {
  final Quiz quiz;
  final QuestionsViewModel model;

  QuestionsView({required this.quiz})
      : model = locator<QuestionsViewModel>(param1: quiz);

  PreferredSizeWidget _createAppbar() {
    return AppBar(
      title: Text(quiz.title),
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: model.onAppBarBackPress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppbar(),
      body: ScaffoldMessenger(
        key: model.nestedScaffoldKey,
        child: Navigator(
          key: model.nestedNavKey,
          onGenerateRoute: nestedGenerateRoute,
          initialRoute: questionsRouteStart,
        ),
      ),
    );
  }
}

class QuestionsStartPage extends StatelessWidget {
  const QuestionsStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class QuestionsViewPage extends StatelessWidget {
  final Question question;
  final Function onChoiceSelected;

  const QuestionsViewPage({
    Key? key,
    required this.question,
    required this.onChoiceSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              question.question,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            VerticalSpace.large,
            ChoicesGrid(
              choices: question.choicesList,
              onChoiceSelect: onChoiceSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionsFinishedPage extends StatelessWidget {
  const QuestionsFinishedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "You've finished this quiz, Hooray!",
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
