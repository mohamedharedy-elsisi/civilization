class ObeliskModel {
  final int id;
  final String name;
  final String arabicName;
  final String city;
  final String location;
  final String historicalEra;
  final String builder;
  final String description;
  final List<String> images;

  ObeliskModel({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.city,
    required this.location,
    required this.historicalEra,
    required this.builder,
    required this.images,
    required this.description,
  });

  factory ObeliskModel.fromJson(
      Map<String, dynamic> json) {
    return ObeliskModel(
      id: json["id"],
      name: json["name"],
      arabicName: json["arabic_name"],
      city: json["city"],
      location: json["location"],
      historicalEra: json["historical_era"],
      builder: json["builder"],
      description: json["description"],
      images: List<String>.from(json['images'],),
    );
  }
}