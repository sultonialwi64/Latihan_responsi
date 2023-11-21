import 'package:flutter/material.dart';
import '../model.dart';
import 'blog_source.dart';
import 'blog_detail.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOGS LIST'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.getBlog(),
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
                var blogs = spacesModel.results![index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BlogDetail(idBlog: blogs.id!),
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
                              blogs.imageUrl ?? '',
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
                                  blogs.title ?? '',
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