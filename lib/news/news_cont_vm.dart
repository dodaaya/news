import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/NewsResponse.dart';

class NewsContVM extends ChangeNotifier {
  List<News>? newsList;
  String? errmsg;

  void getNewsBySrcId(String srcId) async {
    newsList = null;
    errmsg = null;
    notifyListeners();
    try {
      var response =
          await ApiManager.getNewsBySourceId(sourceId: srcId, pageNum: 1);
      if (response?.status == 'error') {
        errmsg = response?.message;
      } else {
        newsList = response?.articles;
      }
    } catch (e) {
      errmsg = 'error loading news list';
    }
    notifyListeners();
  }
}
