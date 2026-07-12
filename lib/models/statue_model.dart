class StatueModel {
  final int id;
  final String name;
  final String arabicName;
  final String location;
  final String period;
  final String material;
  final double heightM;
  final String description;
  final List<String> images;

  StatueModel({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.location,
    required this.period,
    required this.material,
    required this.heightM,
    required this.description,
     required this.images,
  });

  factory StatueModel.fromJson(
      Map<String, dynamic> json) {
    return StatueModel(
      id: json["id"],
      name: json["name"],
      arabicName: json["arabic_name"],
      location: json["location"],
      period: json["period"],
      material: json["material"],
      heightM: (json["height_m"] as num).toDouble(),
      description: json["description"],
      images: List<String>.from(json["images"]),
    );
  }
}