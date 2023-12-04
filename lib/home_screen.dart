import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/assignments/category_search.dart';
import 'package:news/category/category_details.dart';
import 'package:news/category/category_fragment.dart';
import 'package:news/home_drawer.dart';
import 'package:news/model/categoryDM.dart';
import 'package:news/myTheme.dart';
import 'package:news/settings/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.white,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              selectedMenuItem == HomeDrawer.settings
                  ? 'Settings'
                  : selectedCat == null
                      ? AppLocalizations.of(context)!.app_title
                      : '${selectedCat?.title}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CategorySearchDelegate());
                    // Navigator.pushNamed(context, CategorySearch.routeName);
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          drawer: Drawer(
            child: HomeDrawer(
              onSideMenuItem: onSideMenuItem,
            ),
          ),
          body: selectedMenuItem == HomeDrawer.settings
              ? SettingsTab()
              : selectedCat == null
                  ? CategoryFragment(
                      onCatClick: onCatClick,
                    )
                  : CategoryDetails(
                      categoryDM: selectedCat!,
                    ),
        )
      ],
    );
  }

  CategoryDM? selectedCat;

  void onCatClick(CategoryDM newSelectedCat) {
    selectedCat = newSelectedCat;
    setState(() {});
  }

  int selectedMenuItem = HomeDrawer.categories;

  void onSideMenuItem(int newSelectedMenuItem) {
    selectedMenuItem = newSelectedMenuItem;
    selectedCat = null;
    Navigator.pop(context);
    setState(() {});
  }
}
