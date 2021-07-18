import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/viewModels/questions_view_model.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';
import 'package:quiz_app/ui/widgets/choices_grid.dart';

class QuestionsView extends StatefulWidget {
  final Quiz quiz;

  QuestionsView({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  @override
  _QuestionsViewState createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 1),
    vsync: this,
  );

  // Defines animations for sliding a page onto / off of the screen.
  late final Animation slideIn = Tween<Offset>(
    begin: Offset(0, 1),
    end: Offset(0, 0),
  ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);

  late final Animation slideOut = Tween<Offset>(
    begin: Offset(0, 0),
    end: Offset(0, -1),
  ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
      ),
      body: BaseView<QuestionsViewModel, Quiz, AnimationController>(
        param: widget.quiz,
        paramTwo: _controller,
        builder: (context, model, child) {
          if (model.finished) {
            // TODO: implement finished page
            return Container();
          } else if (model.currentQuestion == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                _Page(
                  question: model.nextQuestion,
                  onPressed: model.onChoiceSelected,
                ),
                _Page(
                  question: model.currentQuestion,
                  onPressed: model.onChoiceSelected,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({
    Key? key,
    required this.question,
    required this.onPressed,
  }) : super(key: key);

  final Question? question;
  final Function onPressed;

  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: (widget.question != null)
            ? [
                Text(widget.question!.question),
                VerticalSpace.large,
                ChoicesGrid(
                  choices: widget.question!.choicesList,
                  onChoiceSelect: widget.onPressed,
                )
              ]
            : [
                Container(
                  child: Text('Happy Birthday'),
                ),
              ],
      ),
    );
  }
}
