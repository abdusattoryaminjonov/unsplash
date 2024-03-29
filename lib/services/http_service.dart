import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:unsplash/models/image_collections_model.dart';
import 'package:unsplash/models/image_search_model.dart';
import '../models/image_collection_model.dart';
import 'http_helper.dart';

class Network{
  static bool isTester = true;
  static String BASE_DEV= "api.unsplash.com";
  static String BASE_PRO = "api.unsplash.com";
  static Map<String,String> headers = {'Content-Type':'application/json; charset=UTF-8'};

  static final client = InterceptedClient.build(
    interceptors: [HttpInterceptor()],
    retryPolicy: HttpRetryPolicy(),
  );

  static String getServer() {
    if (isTester) return BASE_DEV;
    return BASE_PRO ;
  }

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async{
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> POST(String api, Map<String, String> params) async{
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.post(uri, body: jsonEncode(params));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.put(uri, body: jsonEncode(params));
      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> DEL(String api, Map<String, String> params) async{
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.delete(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static _throwException(Response response) {
    String reason = response.reasonPhrase!;
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(reason);
      case 401:
        throw InvalidInputException(reason);
      case 403:
        throw UnauthorisedException(reason);
      case 404:
        throw FetchDataException(reason);
      case 500:
      default:
        throw FetchDataException(reason);
    }
  }

  /* Http Apis*/
  static String API_SEARCH_PHOTOS = "/search/photos";
  static String API_COLLECTIONS = "/collections";
  static String API_COLLECTIONS_ID = "/collections/:id/photos";


  /* Http Params */
  static Map<String, String> paramsSearch(String search,int currentPage) {
    Map<String, String> params = Map();
    params.addAll({
      'client_id': HttpInterceptor.API_KEY,
      'page':currentPage.toString(),
      'query':search,
    'per_page':'20'

    });
    return params;
  }

  static Map<String, String> paramsCollections() {
    Map<String, String> params = Map();
    params.addAll({
      'client_id': HttpInterceptor.API_KEY,
      'page':'8',
      'per_page':'20'
    });
    return params;
  }

  static Map<String, String> paramsCollection() {
    Map<String, String> params = Map();
    params.addAll({
      'client_id': HttpInterceptor.API_KEY,
      'page':'1',
      'per_page':'20',
      'orientation':'landscape'
    });
    return params;
  }

  /* Http Parsing */

  static ImageModell parseImageModel(String response) {
    dynamic json = jsonDecode(response);
    return ImageModell.fromJson(json);
  }

  static List<ImageCollections> parseCollections(String response) {
    dynamic json = jsonDecode(response);
    return List<ImageCollections>.from(json.map((x) => ImageCollections.fromJson(x)));
  }

  static List<ImageCollection> parseCollection(String response) {
    dynamic json = jsonDecode(response);
    return List<ImageCollection>.from(json.map((x) => ImageCollection.fromJson(x)));
  }
}