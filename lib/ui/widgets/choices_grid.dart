import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';

/// 4x1 grid of randomly ordered, tappable choices.
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
  final Duration duration = const Duration(seconds: 1, milliseconds: 400);
  final Duration length = const Duration(milliseconds: 500);

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

    for (int num in widget.order) {
      tiles.add(
        _ChoicesTile(
          choice: widget.choices[num],
          onChoiceSelect: widget.onChoiceSelect,
        ),
      );
      tiles.add(VerticalSpace.small);
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
        side:
            MaterialStateProperty.all(BorderSide(color: Colors.teal, width: 2)),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        )),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(56)),
      ),
      onPressed: (choice.isCorrect)
          ? () => onChoiceSelect(choice)
          : () => onChoiceSelect(
                choice,
                SnackBar(
                  duration: Duration(seconds: 3),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  content: Container(
                    alignment: Alignment.center,
                    height: sh * 0.10,
                    child: Text(
                      choice.hintText!,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  backgroundColor: Colors.red[900],
                ),
              ),
      child: Text(
        choice.text,
        textAlign: TextAlign.center,
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