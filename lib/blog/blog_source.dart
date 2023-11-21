import 'package:latihan_responsi/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> getBlog() {
    return BaseNetwork.get("blogs");
  }

  Future<Map<String, dynamic>> getDetailBlog(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("blogs/$id");
  }
}