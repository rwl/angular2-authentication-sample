library angular2.authentication.sample.common.jit.injectables;

import 'package:angular2/change_detection.dart' show ChangeDetection, JitChangeDetection;
import 'package:angular2/di.dart' show bind;

final jitInjectables = [
  bind(ChangeDetection).toClass(JitChangeDetection)
];
