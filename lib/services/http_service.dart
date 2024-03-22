import 'dart:convert';

import 'package:http/http.dart';
import 'package:unsplash/models/image_modell.dart';

class Network{
  static String BASE = "api.unsplash.com";
  static String CLIENT_ID = "DFBUdDTjQJ8BSer4c6X_XuspGXYg1GgwzRND8Agd7QQ";
  static Map<String,String> headers = {
    'Content-Type':'application/json; charset=UTF-8',
    'client_id':CLIENT_ID
  };

  /* Http Apis*/
  static String API_SEARCH_PHOTOS = "/search/photos";
  static String API_SEARCH_COLLECTIONS = "/search/collections";
  static String API_COLLECTIONS_ID = "/collections/:id/photos";

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async{
    var uri = Uri.http(BASE, api, params);
    print(uri);
    var response = await get(uri, headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async{
    var uri = Uri.http(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async{
    var uri = Uri.http(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async{
    var uri = Uri.http(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  /* Http Params */
  static Map<String, String> paramsSearch() {
    Map<String, String> params = Map();
    params.addAll({
      'page':'1',
      'query':'unsplash',
      'client_id': CLIENT_ID
    });
    return params;
  }

  /* Http Parsing */

  static ImageModell parseImageModel(String response) {
    dynamic json = jsonDecode(response);
    return ImageModell.fromJson(json);
  }
}