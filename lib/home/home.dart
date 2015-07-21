library angular2.authentication.sample.home;

import 'dart:html' show window, HttpRequest;
import 'package:angular2/angular2.dart' show Component, View;
import 'package:angular2/directives.dart' show coreDirectives;
import '../utils/fetch.dart' show status, text;
import 'package:angular2/router.dart' show Router;
import 'package:dart_jwt/dart_jwt.dart';

const styles = '/packages/angular2_authentication_sample/home/home.css';

const templateUrl = '/packages/angular2_authentication_sample/home/home.html';

@Component(selector: 'home')
@View(
    styles: const [styles],
    template: '''<div>
  <div class="home jumbotron centered">
    <h1>Welcome to the angular2 authentication sample!</h1>
    <h2 *ng-if="jwt">Your JWT is:</h2>
    <pre *ng-if="jwt" class="jwt"><code>{{ jwt }}</code></pre>
    <pre *ng-if="jwt" class="jwt"><code>{{ decodedJwt | json }}</code></pre>
    <p>Click any of the buttons to call an API and get a response</p>
    <p><a class="btn btn-primary btn-lg" role="button" (click)="callAnonymousApi()">Call Anonymous API</a></p>
    <p><a class="btn btn-primary btn-lg" role="button" (click)="callSecuredApi()">Call Secure API</a></p>
    <p><a class="btn btn-primary btn-lg" role="button" (click)="logout()">Logout</a></p>
    <h2 *ng-if="response">The response of calling the <span class="red">{{api}}</span> API is:</h2>
    <h3 *ng-if="response">{{response}}</h3>
  </div>
</div>
''',
    directives: const [coreDirectives])
class Home {
  String jwt;
  String decodedJwt;
  String response;
  String api;
  Router router;

  Home(Router _router) : router = _router {
    this.jwt = window.localStorage['jwt'];
    if (jwt != null && jwt.isNotEmpty) {
      this.decodedJwt = new JsonWebToken.decode(this.jwt).toString();
    }
  }

  logout() {
    window.localStorage.remove('jwt');
    this.router.parent.navigate('/login');
  }

  callAnonymousApi() {
    _callApi('Anonymous', 'http://localhost:3001/api/random-quote');
  }

  callSecuredApi() {
    _callApi('Secured', 'http://localhost:3001/api/protected/random-quote');
  }

  _callApi(type, url) {
    this.response = null;
    this.api = type;
    HttpRequest.request(url,
      method: 'GET',
      requestHeaders: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'bearer ' + this.jwt
      }
    )
        .then(status)
        .then(text)
        .then((response) {
      this.response = response;
    }).catchError((error) {
      this.response = error.message;
    });
  }
}
