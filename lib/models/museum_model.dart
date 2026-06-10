class MuseumModel {
  final int id;
  final String name;
  final String arabicName;
  final String city;
  final int established;
  final String description;
  final String image;
  final double latitude;
  final double longitude;

  MuseumModel({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.city,
    required this.established,
    required this.description,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  factory MuseumModel.fromJson(
      Map<String, dynamic> json) {
    return MuseumModel(
      id: json["id"],
      name: json["name"],
      arabicName: json["arabic_name"],
      city: json["city"],
      established: json["established"],
      description: json["description"],
      image: json["image"],
      latitude: (json["location"]["latitude"] as num)
          .toDouble(),
      longitude: (json["location"]["longitude"] as num)
          .toDouble(),
    );
  }
}