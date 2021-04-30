import 'package:flutter/foundation.dart' show kIsWeb;

/// Using letter spacing in Flutter for Web can cause a performance drop,
/// see https://github.com/flutter/flutter/issues/51234.
double letterSpacingWorkAround(double letterSpacing) =>
  kIsWeb ? 0.0 : letterSpacing;