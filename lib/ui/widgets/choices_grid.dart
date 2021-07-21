import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';

/// 4x1 of randomly ordered, tappable choices.
class ChoicesGrid extends StatelessWidget {
  /// List of exactly four Choice objects that should be displayed.
  final List<Choice> choices;

  /// Closure to call whenever a choice is tapped.
  final Function onChoiceSelect;

  /// Randomly ordered list to determine how the choices
  /// will be displayed
  final List<int> order;

  ChoicesGrid({
    Key? key,
    required this.choices,
    required this.onChoiceSelect,
  })   : order = [0, 1, 2, 3]..shuffle(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int num in order) ...[
          _ChoicesTile(choice: choices[num], onChoiceSelect: onChoiceSelect),
          VerticalSpace.small
        ]
      ],
    );
  }
}

class _ChoicesTile extends StatelessWidget {
  final Choice choice;
  final Function onChoiceSelect;

  const _ChoicesTile({
    Key? key,
    required this.choice,
    required this.onChoiceSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: (choice.isCorrect)
          ? () => onChoiceSelect(choice)
          : () => onChoiceSelect(
                choice,
                SnackBar(
                  duration: Duration(seconds: 3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  content: Container(
                    height: sh * 0.10,
                    alignment: Alignment.center,
                    child: Text(choice.hintText!),
                  ),
                  backgroundColor: Colors.red[900],
                ),
              ),
      child: Text(
        choice.text,
      ),
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        // TODO: add custom color behaviour using MaterialStateProperty.resolveWith
      ),
    );
  }
}
