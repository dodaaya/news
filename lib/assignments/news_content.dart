import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/myTheme.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsContent extends StatelessWidget {
  static const String routeName = 'content';

  @override
  Widget build(BuildContext context) {
    var news = ModalRoute.of(context)?.settings.arguments as News;
    return Scaffold(
      appBar: AppBar(
        title: Text('News Title'),
      ),
      body: Padding(
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
              news.content ?? "",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 15, color: MyTheme.greyColor),
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
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                onPressed: () {
                  _launchUrl(news.url ?? "");
                },
                label: Text(
                  "View full article",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: MyTheme.paragraphTitleColor),
                ),
                icon: Icon(
                  Icons.play_arrow_rounded,
                  color: MyTheme.paragraphTitleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    var uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch ${uri.path}');
    }
  }
}
