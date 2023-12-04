import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/myTheme.dart';
import 'package:news/news/news_item.dart';

class CategorySearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return MyTheme.lightTheme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            showResults(context);
          },
          icon: Icon(
            Icons.search,
            size: 30,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          size: 29,
          Icons.clear,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Center(
            child: Text(
            'Suggestions',
            textScaleFactor: 1.5,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: MyTheme.primaryLight),
          ))
        : FutureBuilder<NewsResponse?>(
            future: ApiManager.searchNews(query),
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
                    ElevatedButton(onPressed: () {}, child: Text('try again'))
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
              var newsList = snapshot.data?.articles ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItem(news: newsList[index]);
                },
                itemCount: newsList.length,
              );
            });
  }
}
// class CategorySearch extends StatelessWidget {
//   static const String routeName = 'search';
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container(
//           decoration: BoxDecoration(
//               color: MyTheme.white, borderRadius: BorderRadius.circular(22)),
//           child: TextFormField(
//             controller: searchController,
//             onChanged: (text) {
//               searchController.text = text;
//             },
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               icon: Icon(
//                 Icons.clear,
//                 color: MyTheme.primaryLight,
//               ),
//               hintText: 'search article',
//               hintStyle: TextStyle(color: MyTheme.primaryLight, fontSize: 17),
//               suffixIcon: Icon(
//                 Icons.search,
//                 color: MyTheme.primaryLight,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
