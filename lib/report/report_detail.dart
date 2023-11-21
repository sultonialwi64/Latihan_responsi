import 'package:flutter/material.dart';
import 'package:latihan_responsi/model.dart';
import 'report_source.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetail extends StatefulWidget {
  final int idReport;
  const ReportDetail({super.key, required this.idReport});

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  late Results detailReport;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final result = await ApiDataSource.instance.getDetailReport(widget.idReport);
      setState(() {
        detailReport = Results.fromJson(result);
      });
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORTS DETAIL'),
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
              detailReport.imageUrl!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              '${detailReport.title!}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              detailReport.publishedAt!,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              detailReport.summary!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          launchURL(detailReport.url);
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
