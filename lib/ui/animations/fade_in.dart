import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;
  final AnimationController controller;

  /// The delay in milliseconds
  final double delay;
  final Duration duration;

  const FadeIn({
    required this.child,
    required this.controller,
    this.delay = 0.0,
    this.duration = const Duration(seconds: 2),
  });

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  // late final AnimationController _controller;
  late final Animatable<Offset> _position;
  late final Animatable<double> _opacity;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: widget.duration,
    //   vsync: this,
    // )..forward();

    _opacity = Tween(begin: 0.0, end: 1.0).chain(
      CurveTween(
        curve: Interval(
          widget.delay / widget.duration.inMilliseconds,
          1.0,
        ),
      ),
    );

    _position = Tween(begin: Offset(0.0, -0.65), end: Offset.zero).chain(
      CurveTween(
        curve: Interval(
          widget.delay / widget.duration.inMilliseconds,
          1.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity.animate(widget.controller),
      child: SlideTransition(
        child: widget.child,
        position: _position.animate(widget.controller),
      ),
    );
  }
}
