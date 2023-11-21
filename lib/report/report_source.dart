import 'package:latihan_responsi/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> getReport() {
    return BaseNetwork.get("reports");
  }

  Future<Map<String, dynamic>> getDetailReport(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("reports/$id");
  }
}