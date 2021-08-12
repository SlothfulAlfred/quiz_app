import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/ui/animations/fade_in.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';

/// 4x1 grid of randomly ordered, tappable choices which fade in.
class ChoicesGrid extends StatefulWidget {
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
  })   : assert(choices.length == 4),
        order = [0, 1, 2, 3]..shuffle(),
        super(key: key);

  @override
  _ChoicesGridState createState() => _ChoicesGridState();
}

class _ChoicesGridState extends State<ChoicesGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Duration duration = const Duration(seconds: 1, milliseconds: 500);
  final Duration length = const Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildChoiceTiles() {
    List<Widget> tiles = [];
    int delay = 0;
    for (int num in widget.order) {
      tiles.add(
        FadeIn(
          controller: _controller,
          length: length,
          delay: delay,
          child: _ChoicesTile(
              choice: widget.choices[num],
              onChoiceSelect: widget.onChoiceSelect),
        ),
      );
      tiles.add(VerticalSpace.small);
      delay += 200;
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChoiceTiles(),
      ),
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
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.90)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          side: MaterialStateProperty.all(
              BorderSide(color: Colors.teal, width: 2))),
      onPressed: (choice.isCorrect)
          ? () => onChoiceSelect(choice)
          : () => onChoiceSelect(
                choice,
                SnackBar(
                  duration: Duration(seconds: 3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  content: Container(
                    height: sh * 0.08,
                    alignment: Alignment.center,
                    child: Text(
                      choice.hintText!,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  backgroundColor: Colors.red[900],
                ),
              ),
      child: Text(
        choice.text,
        style: Theme.of(context).textTheme.headline2!,
      ),
    );
  }
}

/*
 ButtonStyle(
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
      */