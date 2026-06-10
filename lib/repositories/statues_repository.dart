import '../core/api/api_service.dart';
import '../models/statue_model.dart';

class StatuesRepository {

  final ApiService apiService = ApiService();

  Future<List<StatueModel>> getStatues() async {

    final data = await apiService.getData(
      "/api/statues",
    );

    return data
        .map<StatueModel>(
          (e) => StatueModel.fromJson(e),
    )
        .toList();
  }
}