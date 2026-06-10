class TempleModel {
  final int id;
  final String name;
  final String arabicName;
  final String location;
  final String city;
  final String builtBy;
  final String period;
  final String description;
  final String image;

  TempleModel({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.location,
    required this.city,
    required this.builtBy,
    required this.period,
    required this.description,
    required this.image,
  });

  factory TempleModel.fromJson(
      Map<String, dynamic> json) {
    return TempleModel(
      id: json["id"],
      name: json["name"],
      arabicName: json["arabic_name"],
      location: json["location"],
      city: json["city"],
      builtBy: json["built_by"],
      period: json["period"],
      description: json["description"],
      image: json["image"],
    );
  }
}