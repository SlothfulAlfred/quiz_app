import 'package:flutter/material.dart';

/// Constant vertical spacing for separating widgets.
class VerticalSpace {
  static get large => const SizedBox(
        height: 50,
      );

  static get medium => const SizedBox(
        height: 30,
      );

  static get small => const SizedBox(
        height: 18,
      );

  static get extraSmall => const SizedBox(
        height: 12,
      );
}

/// Constant horizontal spacing for separating widgets.
class HorizontalSpace {
  static get large => const SizedBox(
        width: 50,
      );

  static get medium => const SizedBox(
        width: 30,
      );

  static get small => const SizedBox(
        width: 18,
      );

  static get extraSmall => const SizedBox(
        width: 12,
      );

  static get tiny => const SizedBox(
        width: 6,
      );
}
