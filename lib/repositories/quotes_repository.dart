import '../core/api/api_service.dart';
import '../models/quote_model.dart';

class QuotesRepository {

  final ApiService apiService = ApiService();

  Future<List<QuoteModel>> getQuotes() async {

    final data = await apiService.getData(
      "/api/quotes",
    );

    return data
        .map<QuoteModel>(
          (e) => QuoteModel.fromJson(e),
    )
        .toList();
  }
}