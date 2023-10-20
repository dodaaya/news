import 'package:flutter/material.dart';
import 'package:news/myTheme.dart';

class CategorySearch extends StatelessWidget {
  static const String routeName = 'search';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
              color: MyTheme.white, borderRadius: BorderRadius.circular(22)),
          child: TextFormField(
            controller: searchController,
            onChanged: (text) {
              searchController.text = text;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                Icons.clear,
                color: MyTheme.primaryLight,
              ),
              hintText: 'search article',
              hintStyle: TextStyle(color: MyTheme.primaryLight, fontSize: 17),
              suffixIcon: Icon(
                Icons.search,
                color: MyTheme.primaryLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
