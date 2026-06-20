import '../core/api/api_service.dart';

class SearchRepository {

  final ApiService apiService =
  ApiService();

  Future<List<dynamic>> search(
      String query) async {

    return await apiService.getData(
      "/api/search?q=$query",
    );
  }
}