import 'package:flutter/material.dart';
import '../core/static/saved_card.dart';
import '../core/theme/AppColors.dart';
import '../repositories/search_repository.dart';
import 'DetailsScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final SearchRepository repository = SearchRepository();
  final TextEditingController controller = TextEditingController();
  List<dynamic> results = [];
  bool isLoading = false;
  Future<void> search(
      String value) async {
    if (value.trim().isEmpty) {
      setState(() {
        results = [];
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final data = await repository.search(value);
      setState(() {
        results = data;
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        results = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Search",style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),

            SizedBox(height: 20),
            Expanded(
              child: isLoading ? Center(
                child: CircularProgressIndicator(),
              )
                  : controller.text.isEmpty ? Center(
                child: Text("Start typing to search",style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)),
              )
                  : results.isEmpty ? Center(
                child: Text("No Results Found",style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,)),
              )
                  : ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {

                  final item = results[index];
                  String image = "";
                  if (item["image"] != null) {
                    image = item["image"];
                  }

                  else if (
                  item["images"] != null &&
                      item["images"].isNotEmpty) {
                    image = item["images"][0];
                  }

                  return SavedCard(
                    title: item["name"] ?? "",
                    arabicName: item["arabic_name"] ?? "",
                    image: image,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(
                                id: item["id"],
                                title: item["name"] ?? "",
                                arabicName: item["arabic_name"] ?? "",
                                description: item["description"] ??
                                    item["builder"] ?? item["historical_era"] ?? "",
                                images: item["images"] != null ? List<String>.from(
                                  item["images"],
                                ) : [item["image"]],
                              ),
                        ),
                      );
                    },
                    onSavePressed: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}