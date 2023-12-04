import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/category/cubit/catdet_vmBloc.dart';
import 'package:news/category/cubit/states.dart';
import 'package:news/model/SourceResponse.dart';
import 'package:news/model/categoryDM.dart';
import 'package:news/myTheme.dart';
import 'package:news/tabs/Tab_cont.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'cat_det';
  CategoryDM categoryDM;

  CategoryDetails({required this.categoryDM});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryBlocVM viewModel = CategoryBlocVM();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSourceByCategoryId(widget.categoryDM.id);
  }

  @override
  Widget build(BuildContext context) {
    //cubit,state
    return BlocBuilder<CategoryBlocVM, SrcState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is SrcLoadState) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primaryLight,
              ),
            );
          } else if (state is SrcErrorState) {
            return Column(
              children: [
                Text(state.errmsg!),
                ElevatedButton(onPressed: () {}, child: Text('try again'))
              ],
            );
          } else if (state is SrcSuccessState) {
            return TabContainer(
              sourceslist: state.sourceList!,
            );
          }
          return Container();
        });
    // return ChangeNotifierProvider(
    //     create: (context) => viewModel,
    //     child: Consumer<CatDetVM>(
    //       builder: (context, viewModel, child) {
    //         if (viewModel.errormsg != null) {
    //           return Column(
    //             children: [
    //               Text(viewModel.errormsg!),
    //               ElevatedButton(
    //                   onPressed: () {
    //                     viewModel.getSource(widget.categoryDM.id);
    //                   },
    //                   child: Text('try again'))
    //             ],
    //           );
    //         } else if (viewModel.sourcesList == null) {
    //           return Center(
    //             child: CircularProgressIndicator(
    //               color: MyTheme.primaryLight,
    //             ),
    //           );
    //         } else {
    //           return TabContainer(
    //             sourceslist: viewModel.sourcesList ?? [],
    //           );
    //         }
    //       },
    //       child: Text('header'),
    //     ));

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
