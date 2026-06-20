import 'package:civilization/views/search_screen.dart';
import 'package:flutter/material.dart';
import '../core/static/QuotesCard.dart';
import '../core/static/customCard.dart';
import '../core/theme/AppColors.dart';
import '../models/quote_model.dart';
import '../models/pharaoh_model.dart';
import '../models/statue_model.dart';
import '../models/temple_model.dart';
import '../models/museum_model.dart';
import '../models/obelisk_model.dart';
import '../repositories/quotes_repository.dart';
import '../repositories/pharaohs_repository.dart';
import '../repositories/statues_repository.dart';
import '../repositories/temples_repository.dart';
import '../repositories/museums_repository.dart';
import '../repositories/obelisks_repository.dart';
import '../widgets/section_title.dart';
import 'CategoryScreen.dart';
import 'DetailsScreen.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  final QuotesRepository quotesRepository = QuotesRepository();
  final PharaohsRepository pharaohsRepository = PharaohsRepository();
  final StatuesRepository statuesRepository = StatuesRepository();
  final TemplesRepository templesRepository = TemplesRepository();
  final MuseumsRepository museumsRepository = MuseumsRepository();
  final ObelisksRepository obelisksRepository = ObelisksRepository();

  List<QuoteModel> quotes = [];
  List<PharaohModel> pharaohs = [];
  List<StatueModel> statues = [];
  List<TempleModel> temples = [];
  List<MuseumModel> museums = [];
  List<ObeliskModel> obelisks = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final results =
      await Future.wait([
        quotesRepository.getQuotes(),
        pharaohsRepository.getPharaohs(),
        statuesRepository.getStatues(),
        templesRepository.getTemples(),
        museumsRepository.getMuseums(),
        obelisksRepository.getObelisks(),
      ]);

      quotes = results[0] as List<QuoteModel>;
      pharaohs = results[1] as List<PharaohModel>;
      statues = results[2] as List<StatueModel>;
      temples = results[3] as List<TempleModel>;
      museums = results[4] as List<MuseumModel>;
      obelisks = results[5] as List<ObeliskModel>;
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget sectionTitle(
      String title) {
    return Padding(padding:
      EdgeInsets.only(bottom: 12,),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight:
          FontWeight.bold,
          color: AppColors.font_elfra,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: isLoading ? Center(
          child:
          CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Text("Welcome to\nPharaonic civilization",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight:
                  FontWeight.bold,
                  color: AppColors.font_elfra,
                ),
              ),

              SizedBox(height: 16),
              TextField(
                readOnly: true,
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_) => SearchScreen(),
                    ),
                  );
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 20),
              sectionTitle("Quotes"),
              SizedBox(height: 220,
                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount: quotes.length,
                  itemBuilder:
                      (context,
                      index) {

                        return QuoteCard(
                          imagePath: "assets/quotes_img/quote1.jpeg",
                          quote: quotes[index].quote,
                          author: quotes[index].author,
                        );
                  },
                ),
              ),

              SizedBox(height: 25),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [
                  SectionTitle(title: "Statues"),

                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryScreen(
                                title: "Statues",
                                items: statues,
                                imageBuilder: (item) => item.image,
                                detailsBuilder: (item) => DetailsScreen(
                                  id: item.id,
                                  title: item.name,
                                  arabicName: item.arabicName,
                                  description: item.description,
                                  images: [item.image],
                                ),
                              ),
                        ),
                      );
                    },

                    icon: Icon(Icons.arrow_forward_ios, color: AppColors.font_elfra),
                  ),
                ],
              ),

              SizedBox(height: 260,
                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,
                  itemCount: statues.length > 5 ? 5 : statues.length,

                  itemBuilder:
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  title: statues[index].name,
                                  images: [statues[index].image],
                                  description: statues[index].description,
                                  arabicName: statues[index].arabicName,
                                  id: statues[index].id,
                                ),
                              ),
                            );
                          },

                          child: CustomCard(
                            imageUrl: statues[index].image,
                            title: statues[index].name,
                          ),
                        );
                  },
                ),
              ),

              SizedBox(height: 25),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [
                SectionTitle(title: "Temples"),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryScreen(
                                title: "Temples",
                                items: temples,
                                imageBuilder: (item) => item.image,
                                detailsBuilder: (item) => DetailsScreen(
                                  id: item.id,
                                  title: item.name,
                                  arabicName: item.arabicName,
                                  description: item.description,
                                  images: [item.image],
                                ),
                              ),
                        ),
                      );
                    },

                    icon: Icon(Icons.arrow_forward_ios, color: AppColors.font_elfra,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 260,
                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  temples.length > 5 ? 5 : temples.length,
                  itemBuilder:
                      (context,
                      index) {

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  title: temples[index].name,
                                  images: [temples[index].image],
                                  description: temples[index].description, arabicName: temples[index].arabicName,
                                  id: temples[index].id,
                                ),
                              ),
                            );
                          },

                          child: CustomCard(
                            imageUrl: temples[index].image,
                            title: temples[index].name,
                          ),
                        );
                  },
                ),
              ),

              SizedBox(height: 25),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [
                  SectionTitle(title: "Museums"),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryScreen(
                                title: "Museums",
                                items: museums,
                                imageBuilder: (item) => item.image,
                                detailsBuilder: (item) => DetailsScreen(
                                  id: item.id,
                                  title: item.name,
                                  arabicName: item.arabicName,
                                  description: item.description,
                                  images: [item.image],
                                ),
                              ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.font_elfra,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 260,
                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  museums.length > 5 ? 5 : museums.length,
                  itemBuilder:
                      (context,
                      index) {

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  title: museums[index].name,
                                  images: [museums[index].image],
                                  description: museums[index].description, arabicName: museums[index].arabicName,
                                  id: museums[index].id,
                                ),
                              ),
                            );
                          },

                          child: CustomCard(
                            imageUrl: museums[index].image,
                            title: museums[index].name,
                          ),
                        );
                  },
                ),
              ),

              SizedBox(height: 25),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [
                  SectionTitle(title: "Pharaohs"),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryScreen(
                                title: "Pharaohs",
                                items: pharaohs,
                                imageBuilder: (item) => item.image,
                                detailsBuilder: (item) => DetailsScreen(
                                  id: item.id,
                                  title: item.name,
                                  arabicName: item.arabicName,
                                  description: item.description,
                                  images: [item.image],
                                ),
                              ),
                        ),
                      );
                    },

                    icon: Icon(Icons.arrow_forward_ios, color: AppColors.font_elfra),
                  ),
                ],
              ),

              SizedBox(height: 260,
                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  pharaohs.length > 5 ? 5 : pharaohs.length,
                  itemBuilder:
                      (context,
                      index) {

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  title: pharaohs[index].name,
                                  images: [pharaohs[index].image],
                                  description: pharaohs[index].description, arabicName: pharaohs[index].arabicName,
                                  id: pharaohs[index].id,
                                ),
                              ),
                            );
                          },

                          child: CustomCard(
                            imageUrl: pharaohs[index].image,
                            title: pharaohs[index].name,
                          ),
                        );
                  },
                ),
              ),

              SizedBox(height: 25),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [
                  SectionTitle(title: "Obelisks"),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryScreen(
                                title: "Obelisks",
                                items: obelisks,
                                imageBuilder: (item) => item.images.first,
                                detailsBuilder: (item) => DetailsScreen(
                                  id: item.id,
                                  title: item.name,
                                  arabicName: item.arabicName,
                                  description: item.description,
                                  images: item.images,
                                ),
                              ),
                        ),
                      );
                    },

                    icon: Icon(Icons.arrow_forward_ios, color: AppColors.font_elfra),
                  ),
                ],
              ),

              SizedBox(height: 260,
                child:
                ListView.builder(
                  scrollDirection:
                  Axis.horizontal,

                  itemCount:
                  obelisks.length > 5 ? 5 : obelisks.length,
                  itemBuilder:
                      (context,
                      index) {

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  title: obelisks[index].name,
                                  // image: obelisks[index].images[0],
                                  description: obelisks[index].description,
                                  arabicName: obelisks[index].arabicName,
                                  id: obelisks[index].id,
                                  images: obelisks[index].images,
                                ),
                              ),
                            );
                          },

                          child: CustomCard(
                            imageUrl: obelisks[index].images[0],
                            title: obelisks[index].name,
                          ),
                        );
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}