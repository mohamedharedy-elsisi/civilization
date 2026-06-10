class QuoteModel {
  final int id;
  final String quote;
  final String author;
  final String arabicAuthor;

  QuoteModel({
    required this.id,
    required this.quote,
    required this.author,
    required this.arabicAuthor,
  });

  factory QuoteModel.fromJson(
      Map<String, dynamic> json) {
    return QuoteModel(
      id: json["id"],
      quote: json["quote"],
      author: json["author"],
      arabicAuthor: json["arabic_author"],
    );
  }
}