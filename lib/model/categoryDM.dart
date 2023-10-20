import 'package:flutter/material.dart';
import 'package:news/myTheme.dart';

class CategoryDM {
  String id;
  String title;
  String image;
  Color color;

  CategoryDM({
    required this.id,
    required this.image,
    required this.title,
    required this.color,
  });

  static List<CategoryDM> getCategories() {
    // business entertainment general health science sports technology
    return [
      CategoryDM(
          id: 'sports',
          image: 'assets/images/sports.png',
          title: 'Sports',
          color: MyTheme.redColor),
      CategoryDM(
          id: 'general',
          image: 'assets/images/Politics.png',
          title: 'General',
          color: MyTheme.blueColor),
      CategoryDM(
          id: 'health',
          image: 'assets/images/health.png',
          title: 'Health',
          color: MyTheme.pinkColor),
      CategoryDM(
          id: 'business',
          image: 'assets/images/bussines.png',
          title: 'business',
          color: MyTheme.orangeColor),
      CategoryDM(
          id: 'entertainment',
          image: 'assets/images/enviroment.png',
          title: 'Entertainment',
          color: MyTheme.babyBlueColor),
      CategoryDM(
          id: 'science',
          image: 'assets/images/science.png',
          title: 'Science',
          color: MyTheme.yellowolor),
      CategoryDM(
          id: 'technology',
          image: 'assets/images/science.png',
          title: 'Technology',
          color: MyTheme.blueColor),
    ];
  }
}
