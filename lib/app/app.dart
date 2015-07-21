library angular2.authentication.sample.app;

import 'package:angular2/angular2.dart' show View, Component;
import 'package:angular2/router.dart'
    show Location, RouteConfig, RouterLink, Router;
import './logged_in_outlet.dart' show LoggedInRouterOutlet;
import '../home/home.dart' show Home;
import '../login/login.dart' show Login;
import '../signup/signup.dart' show Signup;

@Component(selector: 'auth-app')
@View(template: '<router-outlet></router-outlet>',
    directives: const [LoggedInRouterOutlet])
@RouteConfig(const [
  const {'path': '/', 'redirectTo': '/home'},
  const {'path': '/home', 'as': 'home', 'component': Home},
  const {'path': '/login', 'as': 'login', 'component': Login},
  const {'path': '/signup', 'as': 'signup', 'component': Signup}
])
class App {
  App(Router router);
}
