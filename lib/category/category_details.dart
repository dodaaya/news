import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/category/cat_det_VM.dart';
import 'package:news/model/SourceResponse.dart';
import 'package:news/model/categoryDM.dart';
import 'package:news/myTheme.dart';
import 'package:news/tabs/Tab_cont.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'cat_det';
  CategoryDM categoryDM;

  CategoryDetails({required this.categoryDM});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CatDetVM viewModel = CatDetVM();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSource(widget.categoryDM.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<CatDetVM>(
          builder: (context, viewModel, child) {
            if (viewModel.errormsg != null) {
              return Column(
                children: [
                  Text(viewModel.errormsg!),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.getSource(widget.categoryDM.id);
                      },
                      child: Text('try again'))
                ],
              );
            } else if (viewModel.sourcesList == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyTheme.primaryLight,
                ),
              );
            } else {
              return TabContainer(
                sourceslist: viewModel.sourcesList ?? [],
              );
            }
          },
          child: Text('header'),
        ));

    FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(widget.categoryDM.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: MyTheme.primaryLight,
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('something went wrong'),
              ElevatedButton(
                  onPressed: () {
                    ApiManager.getSources(widget.categoryDM.id);
                    setState(() {});
                  },
                  child: Text('try again'))
            ],
          );
        }
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(snapshot.data?.message ?? ''),
              ElevatedButton(onPressed: () {}, child: Text('try again'))
            ],
          );
        }

        var sourceslist = snapshot.data?.sources ?? [];
        return TabContainer(sourceslist: sourceslist);
      },
    );
  }
}
