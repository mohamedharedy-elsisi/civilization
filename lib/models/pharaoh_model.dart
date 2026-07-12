class PharaohModel {
  final int id;
  final String name;
  final String arabicName;
  final String dynasty;
  final String reign;
  final String capital;
  final String description;
  final List<String> achievements;
  final List<String> images;

  PharaohModel({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.dynasty,
    required this.reign,
    required this.capital,
    required this.description,
    required this.achievements,
    required this.images,
  });

  factory PharaohModel.fromJson(
      Map<String, dynamic> json) {
    return PharaohModel(
      id: json["id"],
      name: json["name"],
      arabicName: json["arabic_name"],
      dynasty: json["dynasty"],
      reign: json["reign"],
      capital: json["capital"],
      description: json["description"],
      achievements: List<String>.from(json["achievements"]),
      images: List<String>.from(json["images"]),
    );
  }
}