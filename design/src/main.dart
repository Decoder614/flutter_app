import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';

/// The entry point of the Flutter application.
/// Notice how absolutely ZERO logic lives here.
/// We immediately delegate all initialization to [bootstrap].
void main() {
  bootstrap(() => const App());
}
