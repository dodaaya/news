import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_consts.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/model/SourceResponse.dart';

class ApiManager {
  static Future<SourceResponse?> getSources(String categoryId) async {
    // https://newsapi.org/v2/top-headlines/sources?apiKey=c36345bb98b44413aba608c9770954e0

    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourceApi,
        {'apiKey': 'c36345bb98b44413aba608c9770954e0', 'category': categoryId});
    try {
      var respone = await http.get(url);
      var bodyString = respone.body;
      var json = jsonDecode(bodyString);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw (e);
    }
  }

  static Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    //https://newsapi.org/v2/everything?q=bitcoin&apiKey=c36345bb98b44413aba608c9770954e0
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newseApi,
        {'apiKey': 'c36345bb98b44413aba608c9770954e0', 'sources': sourceId});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw (e);
    }
  }
}
