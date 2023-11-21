import 'package:flutter/material.dart';
import 'package:latihan_responsi/model.dart';
import 'blog_source.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetail extends StatefulWidget {
  final int idBlog;
  const BlogDetail({super.key, required this.idBlog});

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  late Results detailBlog;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final result = await ApiDataSource.instance.getDetailBlog(widget.idBlog);
      setState(() {
        detailBlog = Results.fromJson(result);
      });
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOGS DETAIL'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              detailBlog.imageUrl!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              '${detailBlog.title!}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              detailBlog.publishedAt!,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              detailBlog.summary!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          launchURL(detailBlog.url);
        },
        label: const Text(
          'See More',
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(Icons.content_paste_search_rounded, color: Colors.black),
        backgroundColor: const Color(0xFFECDDFF),
      ),
    );
  }

  Future<void> launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error
    }
  }
}
