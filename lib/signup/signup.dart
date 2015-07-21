library angular2.authentication.sample.signup;

import 'dart:convert' show JSON;
import 'dart:html' show window, HttpRequest;
import 'package:angular2/directives.dart' show coreDirectives;
import 'package:angular2/angular2.dart' show Component, View;
import '../utils/fetch.dart' show status, json;
import 'package:angular2/router.dart' show Router, RouterLink;

const styles = '/packages/angular2_authentication_sample/signup/signup.css';
const templateUrl =
    '/packages/angular2_authentication_sample/signup/signup.html';

@Component(selector: 'signup')
@View(
    directives: const [RouterLink, coreDirectives],
    styles: const [styles],
    template: r'''
<div class="login jumbotron center-block">
  <h1>Signup</h1>
  <form role="form" (submit)="signup($event, username.value, password.value)">
  <div class="form-group">
    <label for="username">Username</label>
    <input type="text" #username class="form-control" id="username" placeholder="Username">
  </div>
  <div class="form-group">
    <label for="password">Password</label>
    <input type="password" #password class="form-control" id="password" placeholder="Password">
  </div>
  <button type="submit" class="btn btn-default">Submit</button>
</form>
</div>
''')
class Signup {
  final Router router;

  Signup(Router _router) : router = _router;

  signup(event, username, password) {
    event.preventDefault();
    HttpRequest
        .request('http://localhost:3001/users',
            method: 'POST',
            requestHeaders: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
            sendData: JSON.encode({'username': username, 'password': password}))
        .then(status)
        .then(json)
        .then((response) {
      window.localStorage['jwt'] = response.id_token;
      this.router.navigate('/home');
    }).catchError((error) {
      window.alert(error.message);
      print(error.message);
    });
  }

  login(event) {
    event.preventDefault();
    this.router.parent.navigate('/login');
  }
}
