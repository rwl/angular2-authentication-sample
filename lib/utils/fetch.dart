library angular2.authentication.sample.util;

import 'dart:async';
import 'dart:html' show HttpRequest;
import 'dart:convert' show JSON;

Future<HttpRequest> status(HttpRequest response) async {
  if (response.status >= 200 && response.status < 300) {
    return response;
  }
  throw new Exception(response.responseText);
}

Future<String> text(HttpRequest response) async {
  return response.responseText;
}

Future<Map> json(HttpRequest response) async {
  return JSON.decode(response.responseText);
}
