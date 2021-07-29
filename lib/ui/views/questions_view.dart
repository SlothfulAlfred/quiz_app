import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';
import 'package:quiz_app/ui/widgets/choices_grid.dart';

class QuestionsStartPage extends StatelessWidget {
  const QuestionsStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ensures that the next question is pushed so it doesn't
    // just load endlessly.
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class QuestionsViewPage extends StatelessWidget {
  final Question question;
  final Function onChoiceSelected;

  const QuestionsViewPage(
      {Key? key, required this.question, required this.onChoiceSelected})
      : super(key: key);

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
