import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/model/SourceResponse.dart';
import 'package:news/myTheme.dart';
import 'package:news/news/news_cont_vm.dart';
import 'package:news/news/news_item.dart';
import 'package:provider/provider.dart';

class NewsContainer extends StatefulWidget {
  Source source;

  NewsContainer({required this.source});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  NewsContVM viewModel = NewsContVM();
  final scrollController = ScrollController();
  int pageNum = 1;
  List<News> news = [];
  bool loadNextPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool Top = scrollController.position.pixels == 0;
        if (!Top) {
          print('At bottom');
          loadNextPage = true;
          setState(() {});
        }
      }
    });
    viewModel.getNewsBySrcId(widget.source.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    if (loadNextPage) {
      ApiManager.getNewsBySourceId(
              sourceId: widget.source.id ?? "", pageNum: ++pageNum)
          .then((NewsResponse) => news?.addAll(NewsResponse?.articles ?? []));
      loadNextPage = false;
      setState(() {});
    }
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<NewsContVM>(
        builder: (context, viewModel, child) {
          if (viewModel.errmsg != null) {
            return Column(
              children: [
                Text(viewModel.errmsg!),
                ElevatedButton(
                    onPressed: () {
                      viewModel.getNewsBySrcId(widget.source.id ?? "");
                    },
                    child: Text('try again'))
              ],
            );
          } else if (viewModel.newsList != null) {
            if (news.isEmpty) {
              news = viewModel.newsList ?? [];
            } else if (viewModel.newsList!.isNotEmpty &&
                news.first.title != viewModel.newsList![0].title) {
              news = viewModel.newsList ?? [];
              scrollController.jumpTo(0);
            }
            print(news.length);
            print(pageNum);
            return ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                return NewsItem(news: news![index]);
              },
              itemCount: news?.length ?? 0,
            );
          } else if (viewModel.newsList == null) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primaryLight,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
  }
}
// FutureBuilder<NewsResponse?>(
//     future: ApiManager.getNewsBySourceId(sourceId:widget.source.id ?? ""),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: CircularProgressIndicator(
//             color: MyTheme.primaryLight,
//           ),
//         );
//       } else if (snapshot.hasError) {
//         return Column(
//           children: [
//             Text('something went wrong'),
//             ElevatedButton(onPressed: () {}, child: Text('try again'))
//           ],
//         );
//       }
//       if (snapshot.data?.status != 'ok') {
//         return Column(
//           children: [
//             Text(snapshot.data?.message ?? ''),
//             ElevatedButton(onPressed: () {}, child: Text('try again'))
//           ],
//         );
//       }
//       var newsList = snapshot.data?.articles ?? [];
//       return ListView.builder(
//         itemBuilder: (context, index) {
//           return NewsItem(news: newsList[index]);
//         },
//         itemCount: newsList.length,
//       );
//     });
//
