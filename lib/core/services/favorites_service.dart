import 'package:hive_flutter/hive_flutter.dart';

class FavoritesService {

  static const String boxName = "favorites";

  static Future<void> init() async {
    await Hive.openBox(boxName);
  }

  static Box get box => Hive.box(boxName);

  static void addFavorite(
      Map<String, dynamic> item) {

    box.put(item["id"].toString(), item,);
  }

  static void removeFavorite(int id) {
    box.delete(id.toString());


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