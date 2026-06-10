import '../core/api/api_service.dart';
import '../models/obelisk_model.dart';

class ObelisksRepository {

  final ApiService apiService = ApiService();

  Future<List<ObeliskModel>> getObelisks() async {

    final data = await apiService.getData(
      "/api/obelisks",
    );

    return data
        .map<ObeliskModel>(
          (e) => ObeliskModel.fromJson(e),
    )
        .toList();
  }
}