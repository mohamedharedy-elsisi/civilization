import '../core/api/api_service.dart';
import '../models/pharaoh_model.dart';

class PharaohsRepository {

  final ApiService apiService = ApiService();

  Future<List<PharaohModel>> getPharaohs() async {

    final data = await apiService.getData(
      "/api/pharaohs",
    );

    return data
        .map<PharaohModel>(
          (e) => PharaohModel.fromJson(e),
    )
        .toList();
  }
}