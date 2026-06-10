import '../core/api/api_service.dart';
import '../models/museum_model.dart';

class MuseumsRepository {

  final ApiService apiService = ApiService();

  Future<List<MuseumModel>> getMuseums() async {

    final data = await apiService.getData(
      "/api/museums",
    );

    return data
        .map<MuseumModel>(
          (e) => MuseumModel.fromJson(e),
    )
        .toList();
  }
}