import 'package:flutter/material.dart';
import 'package:news/myTheme.dart';

class HomeDrawer extends StatelessWidget {
  static const int categories = 1;
  static const int settings = 2;
  Function onSideMenuItem;

  HomeDrawer({required this.onSideMenuItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.09),
            color: MyTheme.primaryLight,
            child: Text(
              'News App!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              onSideMenuItem(HomeDrawer.categories);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Categories ',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              onSideMenuItem(HomeDrawer.settings);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Settings ',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
