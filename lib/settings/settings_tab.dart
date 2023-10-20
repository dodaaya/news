import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/myTheme.dart';
import 'package:news/providers/app_config_provider.dart';
import 'package:news/settings/language_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Stack(children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: MyTheme.white,
                    border: Border.all(
                      color: MyTheme.primaryLight,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        provider.appLanguage == 'en'
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: MyTheme.primaryLight)),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: MyTheme.primaryLight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(12),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: ((context) => LanguageBottomSheet()));
  }
}
