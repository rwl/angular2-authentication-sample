library angular2.authentication.sample.login;

import 'dart:convert' show JSON;
import 'dart:html' show window, HttpRequest;
import 'package:angular2/angular2.dart' show Component, View;
import '../utils/fetch.dart' show status, json;
import 'package:angular2/router.dart' show Router, RouterLink;

const styles = '/packages/angular2_authentication_sample/login/login.css';
const templateUrl = '/packages/angular2_authentication_sample/login/login.html';

@Component(selector: 'login')
@View(styles: const [styles], template: r'''
<div class="login jumbotron center-block">
  <h1>Login</h1>
  <form role="form" (submit)="login($event, username.value, password.value)">
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
''', directives: const [RouterLink])
class Login {
  final Router router;

  Login(Router _router) : router = _router;

  login(event, username, password) {
    event.preventDefault();
    HttpRequest
        .request('http://localhost:3001/sessions/create',
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
      this.router.parent.navigate('/home');
    }).catchError((error) {
      window.alert('${error}');
      print('$error');
    });
  }

  signup(event) {
    event.preventDefault();
    this.router.parent.navigate('/signup');
  }
}
