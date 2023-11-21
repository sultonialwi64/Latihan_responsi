import 'package:flutter/material.dart';
import '../model.dart';
import 'news_source.dart';
import 'news_detail.dart';


class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS LIST'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.getNews(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERROR'),
            );
          }
          if (snapshot.hasData) {
            SpacesModel spacesModel = SpacesModel.fromJson(snapshot.data!);
            return ListView.builder(
              itemCount: spacesModel.results!.length,
              itemBuilder: (BuildContext context, int index) {
                var news = spacesModel.results![index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsDetail(idNews: news.id!),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                      color: Color(0xFFF8F2FA),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              news.imageUrl ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.title ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}