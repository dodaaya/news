import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/assignments/category_search.dart';
import 'package:news/assignments/news_content.dart';
import 'package:news/home_screen.dart';
import 'package:news/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

import 'myTheme.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        CategorySearch.routeName: (context) => CategorySearch(),
        NewsContent.routeName: (context) => NewsContent(),
      },
      theme: MyTheme.lightTheme,
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
