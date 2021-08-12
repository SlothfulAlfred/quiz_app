import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;
  final AnimationController controller;

  /// The delay in milliseconds.
  final int delay;

  /// The total length of the animation. The [duration] parameter of the
  /// [AnimationController] provided.
  final Duration duration;

  /// The length of this animation.
  final Duration length;

  FadeIn({
    required this.child,
    required this.controller,
    this.delay = 0,
    this.duration = const Duration(seconds: 2),
    Duration? length,
  }) : length =
            length ?? Duration(milliseconds: duration.inMilliseconds - delay);

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
    int duration = widget.duration.inMilliseconds;
    int delay = widget.delay;
    int length = widget.length.inMilliseconds;

    _opacity = Tween(begin: 0.0, end: 1.0).chain(
      CurveTween(
        curve: Interval(
          delay / duration,
          (delay + length <= duration) ? (delay + length) / duration : 1.0,
        ),
      ),
    );

    _position = Tween(begin: Offset(0.0, -0.65), end: Offset.zero).chain(
      CurveTween(
        curve: Interval(
          delay / duration,
          (delay + length <= duration) ? (delay + length) / duration : 1.0,
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
