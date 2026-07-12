import 'package:hive_flutter/hive_flutter.dart';

class FavoritesService {

  static const String boxName = "favorites";

  static Future<void> init() async {
    await Hive.openBox(boxName);
  }

  static Box get box => Hive.box(boxName);

  static Future<void> addFavorite(
      Map<String, dynamic> item,
      ) async {
    await box.put(
      item["id"].toString(),
      item,
    );
  }

  static Future<void> removeFavorite(
      int id,
      ) async {
    await box.delete(
      id.toString(),
    );
  }

  static bool isFavorite(int id) {

    return box.containsKey(
      id.toString(),
    );
  }

  static List<Map> getFavorites() {

    return box.values.cast<Map>().toList();
  }
}