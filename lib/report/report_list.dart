import 'package:flutter/material.dart';
import '../model.dart';
import 'report_source.dart';
import 'report_detail.dart';

class ReportList extends StatefulWidget {
  const ReportList({super.key});

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORTS LIST'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.getReport(),
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
                var reports = spacesModel.results![index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReportDetail(idReport: reports.id!),
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
                              reports.imageUrl ?? '',
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
                                  reports.title ?? '',
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