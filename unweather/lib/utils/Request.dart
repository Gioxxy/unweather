import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'Logger.dart';

class Response {
  int statusCode;
  dynamic body;

  Response(this.statusCode, this.body);
}

class Request {
  
  static const String _host = "api.openweathermap.org";
  static const String _APIKey = "76173de10498da6e19e4b5cd9d491f98";

  static Future<Response> get({String route = "", Map<String, String> params, Function(Response) onResponse}) async {

    if(route[0] != "/"){
      route = "/" + route;
    }

    params.addAll({'appid': _APIKey});

    Uri url = Uri.https(_host, route, params);

    Logger.log("SEND REQ " + url.host + url.path + url.query);
    final res = await http.get(url, headers: {'Content-Type': 'application/json'});
    Logger.logResponse(request: url.host + url.path + url.query, response: res);

    Response response = Response(res.statusCode, json.decode(utf8.decode(res.bodyBytes)));

    if(onResponse != null)
      onResponse(response);

    return response;
  }

  static Future<Response> post({String route = "", Map<String, String> params, Map<String, dynamic> body, Function(Response) onResponse}) async {

    Logger.log("BODY " + body.toString());

    if(route[0] != "/"){
      route = "/" + route;
    }

    params.addAll({'appid': _APIKey});

    Uri url = Uri.https(_host, route, params);

    Logger.log("SEND REQ " + url.host + url.path + url.query);
    final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: json.encode(body));
    Logger.logResponse(request: url.host + url.path + url.query, body: json.encode(body), response: res);

    Response response = Response(res.statusCode, json.decode(utf8.decode(res.bodyBytes)));

    onResponse?.call(response);

    return response;
  }

  static Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
}