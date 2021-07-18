import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';

/// Two by two grid of randomly ordered, tappable choices.
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            _ChoicesTile(
              choice: choices[order[0]],
              onChoiceSelect: onChoiceSelect,
            ),
            HorizontalSpace.tiny,
            _ChoicesTile(
              choice: choices[order[1]],
              onChoiceSelect: onChoiceSelect,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        VerticalSpace.extraSmall,
        Row(
          children: [
            _ChoicesTile(
              choice: choices[order[2]],
              onChoiceSelect: onChoiceSelect,
            ),
            HorizontalSpace.tiny,
            _ChoicesTile(
              choice: choices[order[3]],
              onChoiceSelect: onChoiceSelect,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
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
    return ElevatedButton(
      onPressed: () => onChoiceSelect(choice),
      child: Text(choice.text),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(
          BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // TODO: add custom color behaviour using MaterialStateProperty.resolveWith
      ),
    );
  }
}
