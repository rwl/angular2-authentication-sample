library angular2.authentication.sample.app.logged_in;

import 'dart:html' show window;
import 'package:angular2/angular2.dart' show Directive, Attribute, ElementRef, DynamicComponentLoader;
import 'package:angular2/router.dart' show Router, RouterOutlet;
import 'package:angular2/di.dart' show Injector;
import '../login/login.dart' show Login;

@Directive(
  selector: 'router-outlet'
)
class LoggedInRouterOutlet extends RouterOutlet {
  var publicRoutes;
  final Router _parentRouter;

  LoggedInRouterOutlet(ElementRef _elementRef, DynamicComponentLoader _loader,
                       Router parentRouter, @Attribute('name')String nameAttr) :
      super(_elementRef, _loader, parentRouter, nameAttr),
      _parentRouter = parentRouter {

      this.publicRoutes = {
        '/login': true,
        '/signup': true
      };
  }

  activate(instruction) {
    var url = this._parentRouter.lastNavigationAttempt;
    if (!this.publicRoutes[url] && !window.localStorage.containsKey('jwt')) {
      instruction.component = Login;
    }
    return super.activate(instruction);
  }
}
