import '../core/api/api_service.dart';
import '../models/pyramid_model.dart';

class PyramidsRepository {

  final ApiService apiService = ApiService();
  Future<List<PyramidModel>> getPyramids() async {

    final data = await apiService.getData(
      "/api/pyramids",
    );

    return data.map<PyramidModel>((e) => PyramidModel.fromJson(e),
    )
        .toList();
  }
}