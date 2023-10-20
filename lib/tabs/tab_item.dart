import 'package:flutter/material.dart';
import 'package:news/model/SourceResponse.dart';
import 'package:news/myTheme.dart';

class TabItem extends StatelessWidget {
  bool isSelected;
  Source source;

  TabItem({required this.isSelected, required this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
          color: isSelected ? MyTheme.primaryLight : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(18)),
          border: Border.all(color: MyTheme.primaryLight, width: 3)),
      child: Text(
        source.name ?? '',
        style: TextStyle(
            fontSize: 18,
            color: isSelected ? MyTheme.white : MyTheme.primaryLight),
      ),
    );
  }
}
