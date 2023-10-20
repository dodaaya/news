import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/assignments/news_content.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/myTheme.dart';

class NewsItem extends StatelessWidget {
News news;

  NewsItem({required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(NewsContent.routeName, arguments: news);
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.fill,
                  imageUrl: news.urlToImage ?? "",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.circular(18)),
            SizedBox(
              height: 10,
            ),
            Text(
              news.author ?? "",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14, color: MyTheme.greyColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              news.title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: MyTheme.paragraphTitleColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              news.publishedAt ?? "",
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14, color: MyTheme.greyColor),
            )
          ],
        ),
      ),
    );
  }
}
