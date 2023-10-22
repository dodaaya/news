import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/SourceResponse.dart';

class CatDetVM extends ChangeNotifier {
  List<Source>? sourcesList;
  String? errormsg;

  void getSource(String categoryId) async {
    sourcesList = null;
    errormsg = null;
    notifyListeners();
    try {
      var response = await ApiManager.getSources(categoryId);
      if (response?.status == 'error') {
        errormsg = response?.message;
      } else {
        sourcesList = response?.sources;
      }
    } catch (e) {
      errormsg = 'error loading src list';
    }
    notifyListeners();
  }
}
