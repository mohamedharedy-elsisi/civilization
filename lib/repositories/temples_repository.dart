import '../core/api/api_service.dart';
import '../models/temple_model.dart';

class TemplesRepository {

  final ApiService apiService = ApiService();

  Future<List<TempleModel>> getTemples() async {

    final data = await apiService.getData(
      "/api/temples",
    );

    return data
        .map<TempleModel>(
          (e) => TempleModel.fromJson(e),
    )
        .toList();
  }
}