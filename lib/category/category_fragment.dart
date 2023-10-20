import 'package:flutter/material.dart';
import 'package:news/category/category_item.dart';
import 'package:news/model/categoryDM.dart';

class CategoryFragment extends StatelessWidget {
  var categoriesList = CategoryDM.getCategories();
  Function onCatClick;

  CategoryFragment({required this.onCatClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pick your category \n of interest',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 23,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onCatClick(categoriesList[index]);
                  },
                  child: CategoryItem(
                      categoryDM: categoriesList[index], index: index),
                );
              },
              itemCount: categoriesList.length,
            ),
          )
        ],
      ),
    );
  }
}
