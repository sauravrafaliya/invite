
import 'package:flutter/cupertino.dart';

/// Provides utility methods for accessing screen size information.
extension SizeUtils on BuildContext {
  /// Gets the width of the screen.
  double get screenWidth {
    return MediaQuery.of(this).size.width;
  }

  /// Gets the height of the screen.
  double get screenHeight {
    return MediaQuery.of(this).size.height;
  }
}