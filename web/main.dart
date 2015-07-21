
import 'package:angular2/angular2.dart' show bootstrap;
import 'package:angular2/di.dart' show bind;
import 'package:angular2/router.dart' show routerInjectables;
import 'package:angular2/forms.dart' show formInjectables;
import 'package:angular2/http.dart' show httpInjectables;

import 'package:angular2/src/reflection/reflection.dart' show reflector;
import 'package:angular2/src/reflection/reflection_capabilities.dart';

import 'package:angular2_authentication_sample/app/app.dart' show App;

main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();
  bootstrap(
    App,
    [
      formInjectables,
      routerInjectables,
      httpInjectables
    ]
  );
}
